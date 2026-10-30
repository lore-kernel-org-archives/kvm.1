Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.133.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793563842;
	b=q90U5jgNEJip7ODmbJX8bEgcregFG6KvVAUTAa91Qx3sKwnSBbs7wrQXfBt+CzzOrU9U
	 IqAQrWLVZMNgwBZ1ggB5gaAeb/6AbDmTd0JvpSNRzzVQG65Eno3XzLktguvLzGDCgDzil
	 sHEkI20oYY/ExpZ74Mc/EZ//kJ7EUocRECRcO/BGJTyR5djLGfSaRiLRSmXeLmtUiAjbr
	 0H7OPvZK+i5Lx5yCrgTCXqd5RzlP2IyqjqbNSS4GlKrP2W3SzNaO6CwmFCpBB4xxGNdVV
	 73/BroqzmVIcdIQuYBQ0hrfqIIXVHKT84ERRykFLz5U3B4Nt4pkLVPGnunQAes8YsVA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793563842;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:Received:Received:Resent-To:
	 Resent-From:Resent-Date:Resent-Message-ID:From:To:Cc:Subject:
	 In-Reply-To:References:Date:Message-ID:User-Agent:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Lines:X-Scanned-By;
	bh=ky1zk6thScAqYqHATy6gr4bYU7NPm4fM3/3dmXxNTDM=;
	b=kLxV3SvhT23wQMvmpMfEKidWQogCbLrIPz7xjpMLexSlJX6qyx3PZB4pOX/2u5o48rA6
	 5Ve9AldK0xfX4QtDWdoupQ4Akyy5jwyW5izATVJUJ7FJEeaYjZcKfgl+lSBQXl6QqTrUn
	 24/2n0YQZ2HcTZmocPmRwmCnevRrrY/klKMfY5di5FlwmNXBNUlT+y6D6vpmvLu4BHXUH
	 dOu2MJKmT83BV4UXXUXlFob5fOl+AQQ0bY+7ucDeIvOvwQw4BK8wZTn2ez1DY6Sxm3mEz
	 /OSnPcErSaPPsMIvfVys7yjOaZm+vhPO5bzrwKDhwSjuWudleA3Y7n6yY6xRFSq2R4w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=WR+SWVYm;
	arc=none smtp.remote-ip=170.10.133.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E63D0606A324
	for <kvm@vger.kernel.org>; Sun,  1 Nov 2026 20:10:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E63D0606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=WR+SWVYm
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1793563840;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:resent-to:
	 resent-from:resent-message-id:in-reply-to:in-reply-to:  references:references;
	bh=ky1zk6thScAqYqHATy6gr4bYU7NPm4fM3/3dmXxNTDM=;
	b=WR+SWVYm6Nle2ckMPipbjVT26FOhy5wssA4kF/yyJgbSV7uh/GZe+CsLU3/1RmkindUBm8
	4mDOhINJN1dzqsw+QqG5DKmjTQZJ9OBgwh3i2IfqVrTe9svL2n1ceDlCBId82lyd8HqKhp
	yGWE1X1lbEpnZ+nZNa3D3uhIKVWkDac=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-400-NyKQmjqwPNCy-wEX0umkxA-1; Sun,
 01 Nov 2026 15:10:39 -0500
X-MC-Unique: NyKQmjqwPNCy-wEX0umkxA-1
X-Mimecast-MFC-AGG-ID: NyKQmjqwPNCy-wEX0umkxA_1793563835
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 872EA1801324;
	Sun,  1 Nov 2026 20:10:34 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.44.22.2])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 853CA30002CF;
	Sun,  1 Nov 2026 20:10:31 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
	id 0F7E521E6A04; Sun, 01 Nov 2026 21:10:29 +0100 (CET)
Resent-To: 17746591750@163.com, alistair@alistair23.me, graf@amazon.com,
 FangSheng.Huang@amd.com, michael.roth@amd.com, jamin_lin@aspeedtech.com,
 kane_chen@aspeedtech.com, palmer@dabbelt.com, rbolshakov@ddn.com,
 foss@defmacro.it, sebastian.huber@embedded-brains.de, fam@euphon.net,
 jiaxun.yang@flygoat.com, lizhijian@fujitsu.com, atar4qemu@gmail.com,
 edgar.iglesias@gmail.com, jasowangio@gmail.com, liwei1518@gmail.com,
 npiggin@gmail.com, zhangckid@gmail.com, titusr@google.com,
 wuhaotsh@google.com, arei.gonglei@huawei.com, berto@igalia.com,
 mark.cave-ayland@ilande.co.uk, junjie.cao@intel.com, zhao1.liu@intel.com,
 its@irrelevant.dk, clg@kaod.org, conor@kernel.org, david@kernel.org,
 jic23@kernel.org, kbusch@kernel.org, mchehab+huawei@kernel.org,
 sstabellini@kernel.org, peter.maydell@linaro.org,
 richard.henderson@linaro.org, pasic@linux.ibm.com,
 zhiwei_liu@linux.alibaba.com, rathc@linux.ibm.com, zhenwei.pi@linux.dev,
 stefanb@linux.vnet.ibm.com, adityag@linux.ibm.com,
 xen-devel@lists.xenproject.org, alifm@linux.ibm.com, luc@lmichel.fr,
 lixianglai@loongson.cn, maobibo@loongson.cn, pbarbuda@microsoft.com,
 yoshinori.sato@nifty.com, qemu-arm@nongnu.org, qemu-block@nongnu.org,
 qemu-devel@nongnu.org, qemu-ppc@nongnu.org, qemu-riscv@nongnu.org,
 qemu-s390x@nongnu.org, john.levon@nutanix.com, thanos.makatos@nutanix.com,
 kfting@nuvoton.com, den@openvz.org, elena.ufimtseva@oracle.com,
 jag.raman@oracle.com, daniel.barboza@oss.qualcomm.com,
 philmd@oss.qualcomm.com, pierrick.bouvier@oss.qualcomm.com,
 phil@philjordan.eu, tangtao1634@phytium.com.cn,
 chao.liu@processmission.com, jiri@resnulli.us, sam@rfc1149.net,
 anisa.su@samsung.com, alex@shazbot.org, farosas@suse.de,
 mohamed@unpredictable.fr, kvm@vger.kernel.org, linux-cxl@vger.kernel.org,
 alistair.francis@wdc.com, anthony@xenproject.org, amachhiw@linux.ibm.com,
 borntraeger@linux.ibm.com, brueckner@linux.ibm.com, farman@linux.ibm.com,
 harshpb@linux.ibm.com, iii@linux.ibm.com, jjherne@linux.ibm.com,
 milesg@linux.ibm.com, mjrosato@linux.ibm.com
Resent-From: Markus Armbruster <armbru@redhat.com>
Resent-Date: Sun, 01 Nov 2026 21:10:29 +0100
Resent-Message-ID: <87mrrs1fey.fsf@pond.sub.org>
From: Markus Armbruster <armbru@redhat.com>
To: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>
Cc: Markus Armbruster <armbru@redhat.com>,  qemu-devel@nongnu.org,  Michael
 Roth <michael.roth@amd.com>,  John Snow <jsnow@redhat.com>,  Peter Maydell
 <peter.maydell@linaro.org>,  Mauro Carvalho Chehab
 <mchehab+huawei@kernel.org>,  Pierrick Bouvier
 <pierrick.bouvier@oss.qualcomm.com>,  Paolo Bonzini <pbonzini@redhat.com>,
  Daniel P. =?utf-8?Q?Berrang=C3=A9?= <berrange@redhat.com>,  Kostiantyn
 Kostiuk
 <kkostiuk@redhat.com>,  Eric Blake <eblake@redhat.com>,  David Hildenbrand
 <david@kernel.org>,  Igor Mammedov <imammedo@redhat.com>,  "Edgar E.
 Iglesias" <edgar.iglesias@gmail.com>,  Jason Wang <jasowangio@gmail.com>,
  Marcelo Tosatti <mtosatti@redhat.com>,  kvm@vger.kernel.org,  Alberto
 Garcia <berto@igalia.com>,  Kevin Wolf <kwolf@redhat.com>,  Hanna Reitz
 <hreitz@redhat.com>,  Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?=
 <philmd@oss.qualcomm.com>,
  Zhao Liu <zhao1.liu@intel.com>,  Jonathan Cameron <jic23@kernel.org>,
  Junjie Cao <junjie.cao@intel.com>,  Anisa Su <anisa.su@samsung.com>,
  Elena Ufimtseva <elena.ufimtseva@oracle.com>,  Jagannathan Raman
 <jag.raman@oracle.com>,  John Levon <john.levon@nutanix.com>,  Thanos
 Makatos <thanos.makatos@nutanix.com>,  =?utf-8?Q?C=C3=A9dric?= Le Goater
 <clg@redhat.com>,
  Cornelia Huck <cohuck@redhat.com>,  Eric Farman <farman@linux.ibm.com>,
  Matthew Rosato <mjrosato@linux.ibm.com>,  Richard Henderson
 <richard.henderson@linaro.org>,  Ilya Leoshkevich <iii@linux.ibm.com>,
  qemu-block@nongnu.org,  linux-cxl@vger.kernel.org,
  qemu-s390x@nongnu.org,  "Michael S. Tsirkin" <mst@redhat.com>,  Sergio
 Lopez <slp@redhat.com>,  qemu-arm@nongnu.org,  Palmer Dabbelt
 <palmer@dabbelt.com>,  Alistair Francis <alistair.francis@wdc.com>,
  Weiwei Li <liwei1518@gmail.com>,  Daniel Henrique Barboza
 <daniel.barboza@oss.qualcomm.com>,  Liu Zhiwei
 <zhiwei_liu@linux.alibaba.com>,  Chao Liu <chao.liu@processmission.com>,
  qemu-riscv@nongnu.org,  Song Gao <17746591750@163.com>,  Bibo Mao
 <maobibo@loongson.cn>,  Xianglai Li <lixianglai@loongson.cn>,  Jiaxun Yang
 <jiaxun.yang@flygoat.com>,  Pedro Barbuda <pbarbuda@microsoft.com>,
  Mohamed Mediouni <mohamed@unpredictable.fr>,  Nicholas Piggin
 <npiggin@gmail.com>,  Harsh Prateek Bora <harshpb@linux.ibm.com>,  Amit
 Machhiwal <amachhiw@linux.ibm.com>,  qemu-ppc@nongnu.org,  Zhang Chen
 <zhangckid@gmail.com>,  Li Zhijian <lizhijian@fujitsu.com>,  Alistair
 Francis <alistair@alistair23.me>,  Alexander Graf <graf@amazon.com>,
  "Gonglei (Arei)" <arei.gonglei@huawei.com>,  zhenwei pi
 <zhenwei.pi@linux.dev>,  Ani Sinha <anisinha@redhat.com>,  Luc Michel
 <luc@lmichel.fr>,  =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@kaod.org>,  Jamin
 Lin
 <jamin_lin@aspeedtech.com>,  Kane Chen <kane_chen@aspeedtech.com>,  Samuel
 Tardieu <sam@rfc1149.net>,  "Denis V. Lunev" <den@openvz.org>,  FangSheng
 Huang <FangSheng.Huang@amd.com>,  Tyrone Ting <kfting@nuvoton.com>,  Hao
 Wu <wuhaotsh@google.com>,  Keith Busch <kbusch@kernel.org>,  Klaus Jensen
 <its@irrelevant.dk>,  Jesper Devantier <foss@defmacro.it>,  Aditya Gupta
 <adityag@linux.ibm.com>,  Glenn Miles <milesg@linux.ibm.com>,  Conor
 Dooley <conor@kernel.org>,  Sebastian Huber
 <sebastian.huber@embedded-brains.de>,  Halil Pasic <pasic@linux.ibm.com>,
  Christian Borntraeger <borntraeger@linux.ibm.com>,  Jason Herne
 <jjherne@linux.ibm.com>,  Titus Rwantare <titusr@google.com>,  Stefano
 Stabellini <sstabellini@kernel.org>,  Anthony PERARD
 <anthony@xenproject.org>,  Peter Xu <peterx@redhat.com>,  Chinmay Rath
 <rathc@linux.ibm.com>,  Hendrik Brueckner <brueckner@linux.ibm.com>,
  xen-devel@lists.xenproject.org,  Roman Bolshakov <rbolshakov@ddn.com>,
  Phil Dennis-Jordan <phil@philjordan.eu>,  Fam Zheng <fam@euphon.net>,
  Farhan Ali <alifm@linux.ibm.com>,  Alex Williamson <alex@shazbot.org>,
  Tao Tang <tangtao1634@phytium.com.cn>,  Stefan Berger
 <stefanb@linux.vnet.ibm.com>,  Fabiano Rosas <farosas@suse.de>,  Mark
 Cave-Ayland <mark.cave-ayland@ilande.co.uk>,  Artyom Tarasenko
 <atar4qemu@gmail.com>,  Yoshinori Sato <yoshinori.sato@nifty.com>,  Jiri
 Pirko <jiri@resnulli.us>,  Eric Auger <eric.auger@redhat.com>,  Laurent
 Vivier <lvivier@redhat.com>
Subject: Re: [PATCH v7 38/65] qom: convert scalar properties to QAPI-aware
 registration
In-Reply-To: <CAMxuvaya+Tihnwjf8JNjhmhBMwE7XpTF8zPL7tbfb8DFiAV62g@mail.gmail.com>
	(=?utf-8?Q?=22Marc-Andr=C3=A9?= Lureau"'s message of "Fri, 30 Oct 2026
 13:01:17 +0400")
References: <20261020-qom-qapi-v7-0-431a86b02b58@redhat.com>
	<20261020-qom-qapi-v7-38-431a86b02b58@redhat.com>
	<87y0bfa81j.fsf@pond.sub.org>
	<CAMxuvaya+Tihnwjf8JNjhmhBMwE7XpTF8zPL7tbfb8DFiAV62g@mail.gmail.com>
Date: Fri, 30 Oct 2026 10:31:46 +0100
Message-ID: <87bj8ba60t.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
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

Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com> writes:

> Hi
>
> On Fri, Oct 30, 2026 at 12:48=E2=80=AFPM Markus Armbruster <armbru@redhat=
.com> wrote:
>>
>> Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com> writes:
>>
>> > Reviewed-by: Amit Machhiwal <amachhiw@linux.ibm.com>
>> > Signed-off-by: Markus Armbruster <armbru@redhat.com>
>> > Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
>>
>> How did you create this patch?  It looks almost mechanical.
>
> Repeated grep / multi-cursor in zed iirc
>
>>
>> It misses a few conversions, almost certainly in code added since you
>> made this patch.  I can take care of them.
>
> Not surprising after several months.

Not at all.  Almost surprised it's so few.

[...]

> Are you working on v8 or should I start rebasing?

I think it's overall less work if I do v8 at this point.

