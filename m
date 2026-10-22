Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.133.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792644464;
	b=Zx3BAWx5P7ph6dH3/T15ohQD3vCB5WLlKSJrizGH+HTzwLFlbioCQ1RD+LBawFqA/bEp
	 kuAHDD+99NRhZrIxO7RgdwpCoBPmIvB915tH69AxQXJV/RNmTdARsEEP9GeiJUcvNBStj
	 GgkfgukkHSPHcCNBSyzydD6kKkKWliL0VBhdGhkPMXx3AZ5kwiOuyb6Fx7y2hGyM0AA5D
	 2H96v75u1Qr71uA8vpXMSsjpvKhX+8NE2eIDI0PCyfrS90gUKiwmCSDmMDV0X7f6RY5LV
	 aW5K0LbdTvzE8rCUmgWpGdltUNvJIZNZ046HM5bQutjgQNHINsCLWuI4x1GUhgnX1sg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792644464;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:Received:From:To:Cc:Subject:
	 In-Reply-To:Organization:References:User-Agent:Date:Message-ID:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:X-Scanned-By;
	bh=dItPU84HwxTFS4lQIuE+WlGML9kLKO6IFhbyWEIdIDQ=;
	b=1gnr9TlXjDnTB+oXFRhEbd+2dcYi+WhlxNwCMxkbt1svPTEdURN3RaTs0LdQtYFb2tLH
	 lx1ljeCI+SPWneCVz9BTMuWozkxD43godXWvtHJyY+XWK1+DrZ2boHa+01T/D8KXv85rz
	 BrCQjUlZc/05IxnBPtThEVwfzlZyu6HxbqeHfamusAB4IYjGwMm+fpdJsHvsOrWQqhPLY
	 CW6vHYlzSD++UpmFdmLhKlGtbrouw6HQ2aaznxnNTllIW36h4vKb1e4vIqg+dRkBmDqyG
	 hCbs1M7PkBWZhjVAi3sAdWdPRaRNyDYEqakxtCT6YwvlPWhbh3Z76ejhk1G3246SY7w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=IkRjhFgy;
	arc=none smtp.remote-ip=170.10.133.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBD90606A31A
	for <kvm@vger.kernel.org>; Thu, 22 Oct 2026 04:47:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EBD90606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=IkRjhFgy
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1792644462;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dItPU84HwxTFS4lQIuE+WlGML9kLKO6IFhbyWEIdIDQ=;
	b=IkRjhFgy0GGF8KAG7xX17wQYWKJVZwpW92maF68w8GdYQHjBNGPl7nOfwZn4C5q2sq9ELy
	ZdUeBJEhJmYtCAD25L7z+u6fg7qoTVVYr0hjYyQl6949c6l35MuA4IMO1VymB7BBEq3nv7
	R7yceUCgWocZO337r+ET1cXzydsfxAI=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-590-7pQmmS0dNJGlEv-HmpyDgw-1; Thu,
 22 Oct 2026 04:47:37 +0000
X-MC-Unique: 7pQmmS0dNJGlEv-HmpyDgw-1
X-Mimecast-MFC-AGG-ID: 7pQmmS0dNJGlEv-HmpyDgw_1792644452
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 0405C1955D4E;
	Thu, 22 Oct 2026 04:47:31 +0000 (UTC)
Received: from localhost (headnet04.pony-001.prod.iad2.dc.redhat.com [10.2.32.116])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 1A1CD30000E3;
	Thu, 22 Oct 2026 04:47:28 +0000 (UTC)
From: Cornelia Huck <cohuck@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>, Alex =?utf-8?Q?Benn=C3=A9e?=
 <alex.bennee@linaro.org>, qemu-devel@nongnu.org
Cc: Bibo Mao <maobibo@loongson.cn>, Christian Borntraeger
 <borntraeger@linux.ibm.com>, Ilya Leoshkevich <iii@linux.ibm.com>,
 Alistair Francis <alistair.francis@wdc.com>, Richard Henderson
 <richard.henderson@linaro.org>, Daniel Henrique Barboza
 <daniel.barboza@oss.qualcomm.com>, Eric Farman <farman@linux.ibm.com>,
 Song Gao <17746591750@163.com>, Harsh Prateek Bora
 <harshpb@linux.ibm.com>, David Hildenbrand <david@kernel.org>, Bernhard
 Beschow <shentey@gmail.com>, Halil Pasic <pasic@linux.ibm.com>, Nicholas
 Piggin <npiggin@gmail.com>, Paul Durrant <paul@xen.org>, =?utf-8?Q?Bj?=
 =?utf-8?Q?=C3=B6rn?= Walk
 <bwalk@linux.ibm.com>, Jiaxun Yang <jiaxun.yang@flygoat.com>, Philippe
 =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>, Palmer Dabbelt
 <palmer@dabbelt.com>, qemu-s390x@nongnu.org, David Woodhouse
 <dwmw2@infradead.org>, Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 qemu-ppc@nongnu.org, Marcelo Tosatti <mtosatti@redhat.com>,
 kvm@vger.kernel.org, qemu-arm@nongnu.org, linux-edac@vger.kernel.org,
 Glenn Miles <milesg@linux.ibm.com>, Chao Liu
 <chao.liu@processmission.com>, Gautam Menghani <gautam@linux.ibm.com>,
 Xianglai Li <lixianglai@loongson.cn>, Pierrick Bouvier
 <pierrick.bouvier@oss.qualcomm.com>, Chinmay Rath <rathc@linux.ibm.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Matthew Rosato
 <mjrosato@linux.ibm.com>, Amit Machhiwal <amachhiw@linux.ibm.com>, Zhao
 Liu <zhao1.liu@intel.com>, Weiwei Li <liwei1518@gmail.com>, Peter Maydell
 <peter.maydell@linaro.org>, Mauro Carvalho Chehab
 <mchehab+huawei@kernel.org>, qemu-riscv@nongnu.org
Subject: Re: [PATCH 00/23] kvm: introduce KVMCPUOps
In-Reply-To: <80b593cf-77e0-4623-8059-937c51dd5cfd@redhat.com>
Organization: "Red Hat GmbH, Sitz: Werner-von-Siemens-Ring 12, D-85630
 Grasbrunn, Handelsregister: Amtsgericht =?utf-8?Q?M=C3=BCnchen=2C?= HRB
 153243,
 =?utf-8?Q?Gesch=C3=A4ftsf=C3=BChrer=3A?= Ryan Barnhart, Charles Cachera,
 Avril Crosse O'Flaherty"
References: <20261020104320.3686723-1-alex.bennee@linaro.org>
 <87se2039dn.fsf@draig.linaro.org>
 <80b593cf-77e0-4623-8059-937c51dd5cfd@redhat.com>
User-Agent: Notmuch/0.40 (https://notmuchmail.org)
Date: Thu, 22 Oct 2026 06:47:24 +0200
Message-ID: <87jyna2vfn.fsf@redhat.com>
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

On Wed, Oct 21 2026, Paolo Bonzini <pbonzini@redhat.com> wrote:

> On 10/20/26 13:21, Alex Benn=C3=A9e wrote:
>> Alex Benn=C3=A9e <alex.bennee@linaro.org> writes:
>>=20
>>> There is a world coming where we can have a KVM interface which
>>> supports multiple architectures. The old style approach of using
>>> linking to resolve per arch kvm_arch_foo handlers won't scale and is
>>> also slightly antithetical to the flexible not-quite object orientated
>>> way we do things in QEMU.
>>=20
>> In case it's not obvious I intended the prefix to be RFC as it needs
>> discussion ;-)
> This generally seems like a good idea, but would this be needed for the=20
> arm-on-s390 support?  Would it use the "single binary" support or would=20
> there be simply two system emulators with KVM support,=20
> qemu-system-aarch64 and qemu-system-s390x?

What would make the most sense logically to me is to use
qemu-system-aarch64 to launch an aarch64 machine and qemu-system-s390x
to launch an s390x machine (at least from an user perspective.) That
said, I haven't looked at this series yet, but it does sound like a good
idea in general regardless of how we plan to launch different arch guests.

