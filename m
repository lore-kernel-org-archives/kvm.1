Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E94FA37AA65
	for <kvm@vger.kernel.org>; Mon,  8 Jun 2026 13:30:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780925413; cv=none; b=lUxULQRn29PTb8C1C/a8hkpu0wANgEzNcQuv90u4EzVjm6mn699xeeaTsTxg8ljBocJIkGnmBBGfEQQ0Fu59QEOAqR1GaSR0tbruLNuWsWzTPqmXEU0uM5Ui/yVkF9u5PRKItzdfDw+Fl0+G3VaPRFDAaSguNCGrczoMEbEioo0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780925413; c=relaxed/simple;
	bh=aUZtO04xjF2N4bHBv8vpQvIY8jUWh9UvLAMqMwSU3po=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=MB+srtVsIZAJ24T4OibmspsrSl1zf3CH7kV1txn6mgU9Z0POuhAwcLfpba4vGJqu9gFonanKwze9mOKURCU1V+U3pS3FrhMQMXZpw5DBK0JNBMTsYYAaBgBPEwparoQmx8TOMZor2g7da8yAYvUWhRjgJCxIVA+JUY6bBF2PTa0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=W5OZzsC9; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="W5OZzsC9"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1780925410;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yydCoCed6+ynC97mmYPUNt3OveMLiukoasGjhCjXbws=;
	b=W5OZzsC9dja5Kjn+QrkgwBqXQI1iB0m3rKwN9YmBaesxymtKTR8QdF7luirV3O4PhxYILS
	jqhVW9dP3DRGwIuSWUytLfviWpzRFBFkkXPRXMPK5g+GqgBowKltH3BX+MiZ6a7utOc9WT
	aXL3XpnOOcUEmcQoLJH9d8Mg/1wHJKE=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-346-LpNAokFvMyyu7BAMMXaYIw-1; Mon,
 08 Jun 2026 09:30:09 -0400
X-MC-Unique: LpNAokFvMyyu7BAMMXaYIw-1
X-Mimecast-MFC-AGG-ID: LpNAokFvMyyu7BAMMXaYIw_1780925406
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 6E1281955F6A;
	Mon,  8 Jun 2026 13:30:05 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.44.22.28])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id A6A7F19560A6;
	Mon,  8 Jun 2026 13:30:04 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
	id 4088E21E6A01; Mon, 08 Jun 2026 15:30:02 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>
Cc: qemu-devel@nongnu.org,  Zhenzhong Duan <zhenzhong.duan@intel.com>,
  "Michael S. Tsirkin" <mst@redhat.com>,  David Hildenbrand
 <david@kernel.org>,  Paolo Bonzini <pbonzini@redhat.com>,  Peter Xu
 <peterx@redhat.com>,  Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?=
 <philmd@mailo.com>,
  qemu-rust@nongnu.org,  Alex Williamson <alex@shazbot.org>,  =?utf-8?Q?C?=
 =?utf-8?Q?=C3=A9dric?= Le
 Goater <clg@redhat.com>,  "Maciej S. Szmigiero"
 <maciej.szmigiero@oracle.com>,  Fabiano Rosas <farosas@suse.de>,  Mark
 Kanda <mark.kanda@oracle.com>,  Ben Chaney <bchaney@akamai.com>,  Marcelo
 Tosatti <mtosatti@redhat.com>,  kvm@vger.kernel.org,  "Dr. David Alan
 Gilbert" <dave@treblig.org>,  Zhao Liu <zhao1.liu@intel.com>,  Eric Blake
 <eblake@redhat.com>
Subject: Re: [PATCH v5 12/12] RFC: monitor: add 'info ramblock-attributes'
 command
In-Reply-To: <20260604-rdm5-v5-12-5768e6a0943d@redhat.com> (=?utf-8?Q?=22M?=
 =?utf-8?Q?arc-Andr=C3=A9?=
	Lureau"'s message of "Thu, 04 Jun 2026 17:43:58 +0400")
References: <20260604-rdm5-v5-0-5768e6a0943d@redhat.com>
	<20260604-rdm5-v5-12-5768e6a0943d@redhat.com>
Date: Mon, 08 Jun 2026 15:30:02 +0200
Message-ID: <87a4t5tb1h.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com> writes:

> Add a new 'info ramblock-attributes' HMP command and the corresponding
> 'x-query-ramblock-attributes' QMP command to display the shared/private
> memory attributes for ram blocks.
>
> The QMP command returns structured data (RamBlockAttributesInfo list
> with per-range shared/populated attributes), while HMP formats it for
> human consumption.
>
> This is useful for debugging confidential guests (TDX, SNP) to inspect
> which memory regions are shared vs private, and their population state
> when a RamDiscardManager is present (e.g. virtio-mem).
>
> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> ---
>  qapi/machine.json             | 56 ++++++++++++++++++++++++++++++++++
>  include/monitor/hmp.h         |  1 +
>  hw/core/machine-hmp-cmds.c    | 32 +++++++++++++++++++
>  system/ram-block-attributes.c | 71 +++++++++++++++++++++++++++++++++++++=
++++++
>  hmp-commands-info.hx          | 13 ++++++++
>  5 files changed, 173 insertions(+)
>
> diff --git a/qapi/machine.json b/qapi/machine.json
> index 685e4e29b87..a1af5c61176 100644
> --- a/qapi/machine.json
> +++ b/qapi/machine.json
> @@ -1738,6 +1738,62 @@
>    'returns': 'HumanReadableText',
>    'features': [ 'unstable' ] }
>=20=20
> +##
> +# @RamBlockAttributeRange:
> +#
> +# A contiguous range within a ram block with uniform attributes.

RAM please.  More of the same below, not flagging it again.

> +#
> +# @start: start offset in bytes within the ram block
> +#
> +# @length: length in bytes of the range
> +#
> +# @shared: true if the range is shared, false if private

Can we assume that anybody with a use for x-query-ramblock-attributes
understands what "range is shared" means?

> +#
> +# @populated: true if the entire range is fully populated across all
> +#     RamDiscardManager sources; false if any sub-block is discarded.
> +#     Only present when a RamDiscardManager is managing the block.

Can we assume that anybody with a use for x-query-ramblock-attributes
understands what "a RamDiscardManager is managing the block" means?

I can't find anything about RamDiscardManager in docs.  Would it make
sense to have something there, so we can point to it here?

> +#
> +# Since: 11.1
> +##
> +{ 'struct': 'RamBlockAttributeRange',
> +  'data': { 'start': 'uint64',
> +            'length': 'uint64',
> +            'shared': 'bool',
> +            '*populated': 'bool' } }
> +
> +##
> +# @RamBlockAttributesInfo:
> +#
> +# Shared/private memory attributes for a ram block.
> +#
> +# @name: the ram block identifier

Apparently, this is a memory region name, obtained with
memory_region_name().  Correct?

If yes, then what about "@name: the memory region name"?  Or maybe "the
name of the RAM block's memory region"?

> +#
> +# @ranges: list of attribute ranges
> +#
> +# Since: 11.1
> +##
> +{ 'struct': 'RamBlockAttributesInfo',
> +  'data': { 'name': 'str',
> +            'ranges': [ 'RamBlockAttributeRange' ] } }
> +
> +##
> +# @x-query-ramblock-attributes:
> +#
> +# Query ram block shared/private attributes.  This is useful
> +# to debug confidential guests.

Ignorant question: how are RAM blocks related to memory regions?

> +#
> +# Features:
> +#
> +# @unstable: This command is meant for debugging.
> +#
> +# Returns: list of ram block attributes
> +#
> +# Since: 11.1
> +##
> +{ 'command': 'x-query-ramblock-attributes',
> +  'returns': [ 'RamBlockAttributesInfo' ],
> +  'features': [ 'unstable' ] }
> +
>  ##
>  # @x-query-roms:
>  #

[...]

