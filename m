Received: from out-183.mta0.migadu.com (out-183.mta0.migadu.com [91.218.175.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4FC33451DA
	for <kvm@vger.kernel.org>; Mon, 10 Aug 2026 04:08:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786334932; cv=none; b=j1kDApT7xG5cAmfVselkpWe+wbo7QQFfvGzmYwtLGDCE+PtD4OWaADfdPFPXEJVdSuLKTKYyxrWU4udDtjOo2NYx0rLO0XqUsjOG6PN6TIkuL1JeL2MgQmC5l7NvWGsesFpvQxNZ6QCYTYhLV2kTcGA8ExJBzf73TJLwTvz4XVo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786334932; c=relaxed/simple;
	bh=vKFcHIw8hz1iOnmr38I3AiGYQS9ZYqAwS+G2lbzI9v8=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=RM19acjaJt/kuoYB19mJjR7PHc1gk0p1ckSXNXC+up3V/r40ZBH63JuLD5IijfeYg/AjkQGjdNdufNFYkbVPdJDPjrr2yyp6jWwDIAnYAu6QPv6lWA57aWBJG089NyLG9QhJCbNAnHaFv3emHsF6GlOQZtVgBT/VlFkTuOnMhg0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=pfdSLxR2; arc=none smtp.client-ip=91.218.175.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="pfdSLxR2"
Date: Mon, 10 Aug 2026 12:08:32 +0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1786334918;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PkNC+gw+Z+aEc1wxEcxbme9tf/BdfvAZ4oDK9fR2xO0=;
	b=pfdSLxR2R+TkXO11c/q2PO7ZhOn7y7Ypej4p/jS31t/Cte0RgfC1uf2iswUGVBhMbMG3bi
	C3GGqwzgNcGXGMAKVZdcqaOBKxGfok1xaRAPt22cfVdh0vAxgWGwFgjizfk/um94d/2CDl
	1xlQ4hoZ/387kpvGANI5PpAe9yBpfxo=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Tao Cui <cui.tao@linux.dev>
To: Huacai Chen <chenhuacai@kernel.org>
CC: zhaotianrui@loongson.cn, maobibo@loongson.cn, kernel@xen0n.name,
 kvm@vger.kernel.org, loongarch@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH_v2=5D_LoongArch=3A_KVM=3A_Adve?=
 =?US-ASCII?Q?rtise_already-supported_capabilities?=
In-Reply-To: <CAAhV-H59uR_WFk5rQDYm=s2_iyr1Gr0D+tE248hrfe3d+2ycog@mail.gmail.com>
References: <20260805054549.287648-1-cui.tao@linux.dev> <CAAhV-H59uR_WFk5rQDYm=s2_iyr1Gr0D+tE248hrfe3d+2ycog@mail.gmail.com>
Message-ID: <4B35E5A9-3CA4-4AE4-BBA7-74ACD1316B6C@linux.dev>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Migadu-Flow: FLOW_OUT

Hi, Huacai

I missed my Signed-off-by tag for this patch, my mistake=2E
Could you append:
Signed-off-by: Tao Cui <cuitao@kylinos=2Ecn>
If it=E2=80=99s not workable, no problem at all=2E

=E4=BA=8E 2026=E5=B9=B48=E6=9C=889=E6=97=A5 GMT+08:00 12:06:36=EF=BC=8CHua=
cai Chen <chenhuacai@kernel=2Eorg> =E5=86=99=E9=81=93=EF=BC=9A
>Applied, thanks=2E
>
>Huacai
>
>On Wed, Aug 5, 2026 at 1:46=E2=80=AFPM Tao Cui <cui=2Etao@linux=2Edev> wr=
ote:
>>
>> Several LoongArch KVM features are fully implemented but were never
>> reported through their standard KVM_CHECK_EXTENSION probes, so userspac=
e
>> cannot discover them=2E  Advertise the ones that already work and have =
a
>> real consumer:
>>
>>   - KVM_CAP_STEAL_TIME: steal time works end-to-end (host-side record
>>     plus guest paravirt side), and the probe returns kvm_pvtime_support=
ed()=2E
>>
>>   - KVM_CAP_VCPU_ATTRIBUTES: per-vCPU device-attribute ioctls are
>>     implemented (CPUCFG, PVTIME control); advertise the discovery cap=
=2E
>>
>> This adds no new functionality; it only makes existing features
>> discoverable via the standard probe=2E
>>
>> Signed-off-by: Tao Cui <cui=2Etao@linux=2Edev>
>> ---
>> Changes in v2:
>>   - Drop KVM_CAP_IRQFD_RESAMPLE: the only consumer is VFIO INTx, which
>>     needs IOMMU/VFIO not yet available on LoongArch=2E
>>   - Drop KVM_CAP_VM_GPA_BITS: the cap implies a GPA-width setter that
>>     LoongArch does not implement=2E
>>
>>  arch/loongarch/kvm/vm=2Ec | 4 ++++
>>  1 file changed, 4 insertions(+)
>>
>> diff --git a/arch/loongarch/kvm/vm=2Ec b/arch/loongarch/kvm/vm=2Ec
>> index 1317c718f896=2E=2E0a51931d6f6e 100644
>> --- a/arch/loongarch/kvm/vm=2Ec
>> +++ b/arch/loongarch/kvm/vm=2Ec
>> @@ -122,6 +122,7 @@ int kvm_vm_ioctl_check_extension(struct kvm *kvm, l=
ong ext)
>>         case KVM_CAP_IOEVENTFD:
>>         case KVM_CAP_MP_STATE:
>>         case KVM_CAP_SET_GUEST_DEBUG:
>> +       case KVM_CAP_VCPU_ATTRIBUTES:
>>                 r =3D 1;
>>                 break;
>>         case KVM_CAP_NR_VCPUS:
>> @@ -136,6 +137,9 @@ int kvm_vm_ioctl_check_extension(struct kvm *kvm, l=
ong ext)
>>         case KVM_CAP_NR_MEMSLOTS:
>>                 r =3D KVM_USER_MEM_SLOTS;
>>                 break;
>> +       case KVM_CAP_STEAL_TIME:
>> +               r =3D kvm_pvtime_supported();
>> +               break;
>>         default:
>>                 r =3D 0;
>>                 break;
>>
