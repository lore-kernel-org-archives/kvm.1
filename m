Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 275A012F585
	for <kvm@vger.kernel.org>; Mon,  8 Jun 2026 13:36:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780925780; cv=none; b=fOLUyb9WFSyiMq5eXAchvD4FT+Vl7wcBdBGgAaeWbS080GoYWO1Ct0yGABdQemS7xp9SXmpSZhsjtHV4KvnYIZ9F5wjZ5doIyhWuivlEUREe7pdZ5v0ieNw7IVc49oRk6cvcNewtCvr/D3odCpbXnMMTLUP2xyvE0/DjnTiuT2E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780925780; c=relaxed/simple;
	bh=KM69Ga9NEv2dtJJ+dnF31Vh4AfsAVpJxTqrFGAU2saM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=AjqB9BcFwxU7yMZUgrvIRN9H6t1DrlK0jCJxXjYIJ68VDW+Q2OF0qmCA5Ze/gPLUMoa61WH/R1NNWMMOkefU7OIojPAocPWEjw74ijVOlEzJ/QRpRujValValFNmMvuPRYzoG3opvzJXCoGf/UW543NOxJdwheKdCVppIYJ0Ors=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=UwVImoeh; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UwVImoeh"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1780925778;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cEhB5J/m8mgVV+kh6n0LLvbd+zdrpCATTf8w3l+ryfk=;
	b=UwVImoeh6xUoSLN05744L/vDT2ov6ky6OL3/W58kThQhUh/DoXPzYaJ4bqMwHH3Jh7yV+F
	L3SGEnxFuR10zKoRVnkW8qeZpuwAoIPYmGZ8Ccdcc1uqe/2DySmBAZdZFwjbqCyw+tBF0b
	F/6tSN6vUGc3MGyDGNXzFaitPuf3oxM=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-101-db76uBcRM4ufi_lJJoliUA-1; Mon,
 08 Jun 2026 09:36:14 -0400
X-MC-Unique: db76uBcRM4ufi_lJJoliUA-1
X-Mimecast-MFC-AGG-ID: db76uBcRM4ufi_lJJoliUA_1780925771
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 912821955DBB;
	Mon,  8 Jun 2026 13:36:10 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.44.22.28])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 580581800367;
	Mon,  8 Jun 2026 13:36:09 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
	id E5DF021E6A01; Mon, 08 Jun 2026 15:36:06 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: "Dr. David Alan Gilbert" <dave@treblig.org>
Cc: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>,
  qemu-devel@nongnu.org,
  Zhenzhong Duan <zhenzhong.duan@intel.com>,  "Michael S. Tsirkin"
 <mst@redhat.com>,  David Hildenbrand <david@kernel.org>,  Paolo Bonzini
 <pbonzini@redhat.com>,  Peter Xu <peterx@redhat.com>,  Philippe
 =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@mailo.com>,  qemu-rust@nongnu.org,
  Alex Williamson
 <alex@shazbot.org>,  =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@redhat.com>,
  "Maciej S.
 Szmigiero" <maciej.szmigiero@oracle.com>,  Fabiano Rosas
 <farosas@suse.de>,  Mark Kanda <mark.kanda@oracle.com>,  Ben Chaney
 <bchaney@akamai.com>,  Marcelo Tosatti <mtosatti@redhat.com>,
  kvm@vger.kernel.org,  Zhao Liu <zhao1.liu@intel.com>,  Eric Blake
 <eblake@redhat.com>
Subject: Re: [PATCH v5 12/12] RFC: monitor: add 'info ramblock-attributes'
 command
In-Reply-To: <aiLO7ZQvowWHwK63@gallifrey> (David Alan Gilbert's message of
	"Fri, 5 Jun 2026 13:28:13 +0000")
References: <20260604-rdm5-v5-0-5768e6a0943d@redhat.com>
	<20260604-rdm5-v5-12-5768e6a0943d@redhat.com>
	<aiLO7ZQvowWHwK63@gallifrey>
Date: Mon, 08 Jun 2026 15:36:06 +0200
Message-ID: <875x3ttard.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

"Dr. David Alan Gilbert" <dave@treblig.org> writes:

> * Marc-Andr=C3=A9 Lureau (marcandre.lureau@redhat.com) wrote:
>> Add a new 'info ramblock-attributes' HMP command and the corresponding
>> 'x-query-ramblock-attributes' QMP command to display the shared/private
>> memory attributes for ram blocks.
>>=20
>> The QMP command returns structured data (RamBlockAttributesInfo list
>> with per-range shared/populated attributes), while HMP formats it for
>> human consumption.
>>=20
>> This is useful for debugging confidential guests (TDX, SNP) to inspect
>> which memory regions are shared vs private, and their population state
>> when a RamDiscardManager is present (e.g. virtio-mem).
>>=20
>> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
>> ---
>>  qapi/machine.json             | 56 ++++++++++++++++++++++++++++++++++
>>  include/monitor/hmp.h         |  1 +
>>  hw/core/machine-hmp-cmds.c    | 32 +++++++++++++++++++
>>  system/ram-block-attributes.c | 71 ++++++++++++++++++++++++++++++++++++=
+++++++
>>  hmp-commands-info.hx          | 13 ++++++++
>>  5 files changed, 173 insertions(+)
>>=20
>
> <snip>
>
> For HMP,
>
> Acked-by: Dr. David Alan Gilbert <dave@treblig.org>
>
> however, you might consider whether it would be better to add it
> to the existing "info ramblock"

Valid suggestion.

HMP "info ramblock" wraps around QMP x-query-ramblock, which returns
HumanReadableText.

HMP "info ramblock-attributes" wraps around QMP
x-query-ramblock-attributes, which returns a list of
RamBlockAttributesInfo.

So, basic x-query-ramblock returns unstructured text, and
x-query-ramblock-attributes returns structured data.  Hmm.  Feels a bit
odd.

[...]

