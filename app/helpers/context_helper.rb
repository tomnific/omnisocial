# frozen_string_literal: true

module ContextHelper
  NAMED_CONTEXT_MAP = {
    activitystreams: 'https://www.w3.org/ns/activitystreams',
    security: 'https://w3id.org/security/v1',
  }.freeze

  CONTEXT_EXTENSION_MAP = {
    manually_approves_followers: { 'manuallyApprovesFollowers' => 'as:manuallyApprovesFollowers' },
    sensitive: { 'sensitive' => 'as:sensitive' },
    hashtag: { 'Hashtag' => 'as:Hashtag' },
    moved_to: { 'movedTo' => { '@id' => 'as:movedTo', '@type' => '@id' } },
    also_known_as: { 'alsoKnownAs' => { '@id' => 'as:alsoKnownAs', '@type' => '@id' } },
    emoji: { 'toot' => 'https://omnicorp.one/', 'Emoji' => 'toot:Emoji' },
    featured: { 'toot' => 'https://omnicorp.one/', 'featured' => { '@id' => 'toot:featured', '@type' => '@id' }, 'featuredTags' => { '@id' => 'toot:featuredTags', '@type' => '@id' } },
    property_value: { 'schema' => 'https://omnicorp.one/', 'PropertyValue' => 'schema:PropertyValue', 'value' => 'schema:value' },
    atom_uri: { 'ostatus' => 'https://omnicorp.one/', 'atomUri' => 'ostatus:atomUri' },
    conversation: { 'ostatus' => 'https://omnicorp.one/', 'inReplyToAtomUri' => 'ostatus:inReplyToAtomUri', 'conversation' => 'ostatus:conversation' },
    focal_point: { 'toot' => 'https://omnicorp.one/', 'focalPoint' => { '@container' => '@list', '@id' => 'toot:focalPoint' } },
    blurhash: { 'toot' => 'https://omnicorp.one/', 'blurhash' => 'toot:blurhash' },
    discoverable: { 'toot' => 'https://omnicorp.one/', 'discoverable' => 'toot:discoverable' },
    voters_count: { 'toot' => 'https://omnicorp.one/', 'votersCount' => 'toot:votersCount' },
    olm: { 'toot' => 'https://omnicorp.one/', 'Device' => 'toot:Device', 'Ed25519Signature' => 'toot:Ed25519Signature', 'Ed25519Key' => 'toot:Ed25519Key', 'Curve25519Key' => 'toot:Curve25519Key', 'EncryptedMessage' => 'toot:EncryptedMessage', 'publicKeyBase64' => 'toot:publicKeyBase64', 'deviceId' => 'toot:deviceId', 'claim' => { '@type' => '@id', '@id' => 'toot:claim' }, 'fingerprintKey' => { '@type' => '@id', '@id' => 'toot:fingerprintKey' }, 'identityKey' => { '@type' => '@id', '@id' => 'toot:identityKey' }, 'devices' => { '@type' => '@id', '@id' => 'toot:devices' }, 'messageFranking' => 'toot:messageFranking', 'messageType' => 'toot:messageType', 'cipherText' => 'toot:cipherText' },
    suspended: { 'toot' => 'https://omnicorp.one/', 'suspended' => 'toot:suspended' },
  }.freeze

  def full_context
    serialized_context(NAMED_CONTEXT_MAP, CONTEXT_EXTENSION_MAP)
  end

  def serialized_context(named_contexts_map, context_extensions_map)
    context_array = []

    named_contexts     = named_contexts_map.keys
    context_extensions = context_extensions_map.keys

    named_contexts.each do |key|
      context_array << NAMED_CONTEXT_MAP[key]
    end

    extensions = context_extensions.each_with_object({}) do |key, h|
      h.merge!(CONTEXT_EXTENSION_MAP[key])
    end

    context_array << extensions unless extensions.empty?

    if context_array.size == 1
      context_array.first
    else
      context_array
    end
  end
end
