Received: from esa5.hc1455-7.c3s2.iphmx.com (esa5.hc1455-7.c3s2.iphmx.com [68.232.139.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 396B1385D99
	for <kvm@vger.kernel.org>; Thu, 30 Jul 2026 06:14:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.139.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785392068; cv=none; b=kmO7lJ7c7hb17jLQ/b66qoEZKxSmNc++/4jpJRulkbrQFLK8Xg18khDRS1HH0BdcD0+2co44SRngn1ZpgSVFiruxEypurFk6zqY6axlaXxQbTWjrY1m63ERx+RBa0fq+yXS4xEA+hQOyrc7RhrxbQfQhcIUFTnhcJ+n0ZBSKX1g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785392068; c=relaxed/simple;
	bh=2JMtIHddTzE0dtxltyyyxoqKtdSqKhmCGJF2z/HOr9Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ld1R702bYn/xwhLXmKJYfRvx18RIhA2MbQ1ezpfigzmjtUmTqL9fhK/r/+ySd3wYuq4gI2SvQBFk8tiPqi+3On8rMoIr5nIQ5e1ramoLCPV9VPWnSYsqKS6cgrbquoje7tVh1z27y8Ki2ttvlY0ZOyBRXwEkni5Vo7p+XQfbtDU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com; spf=pass smtp.mailfrom=fujitsu.com; dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b=AgF07woe; arc=none smtp.client-ip=68.232.139.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b="AgF07woe"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj2;
  t=1785392060; x=1816928060;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=2JMtIHddTzE0dtxltyyyxoqKtdSqKhmCGJF2z/HOr9Q=;
  b=AgF07woe6qzRnbAobNKC6JZ+YA4rW4WFENwXSxKSoxy4Y/7OEuGaY9CI
   dj4HGSgqu9yMa5vNXDnvINswbxQch6nYYH1v/+EGvWDS3iEK+nwXFq0gf
   p7oqk4u3y8GKyuBp8WQC8xQxJi8ZbdP2wLctgStO39r+nKwzATsJKV/QQ
   PUQDS+1j6zmIP9UlqlvIFAuSMCPMnE2UpXtj3p9JHrKVrLcvrKD91vgKm
   bSd4J1s+KXJ6BJ5qs1uJrXIDGxPIfzKHB1OTE4N4B2PRGkuigjXgWK39S
   aGgXKbAbJi4uFXU8DowMX8aGN9PiIVx3nwjbHJfkNhtybakdjWwF+SPCq
   w==;
X-CSE-ConnectionGUID: v1j2sIMVTpe3XYl5y4eX1g==
X-CSE-MsgGUID: ii3a/3RlRJm+hDzyJsBALg==
X-IronPort-AV: E=McAfee;i="6800,10657,11859"; a="247255475"
X-IronPort-AV: E=Sophos;i="6.25,194,1779116400"; 
   d="scan'208";a="247255475"
Received: from gmgwnl01.global.fujitsu.com ([52.143.17.124])
  by esa5.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jul 2026 15:14:09 +0900
Received: from az2nlsmgm4.fujitsu.com (unknown [10.150.26.204])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by gmgwnl01.global.fujitsu.com (Postfix) with ESMTPS id 537F81000378
	for <kvm@vger.kernel.org>; Thu, 30 Jul 2026 06:14:09 +0000 (UTC)
Received: from az2uksmom1.o.css.fujitsu.com (unknown [10.151.22.202])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by az2nlsmgm4.fujitsu.com (Postfix) with ESMTPS id 05C761007106
	for <kvm@vger.kernel.org>; Thu, 30 Jul 2026 06:14:09 +0000 (UTC)
Received: from FCCLS0092175.localdomain (unknown [10.8.194.125])
	by az2uksmom1.o.css.fujitsu.com (Postfix) with SMTP id AA43D18004F3;
	Thu, 30 Jul 2026 06:14:03 +0000 (UTC)
Date: Thu, 30 Jul 2026 15:13:55 +0900
From: Kohei Enju <enju.kohei@fujitsu.com>
To: Gavin Shan <gshan@redhat.com>
Cc: Mathieu Poirier <mathieu.poirier@linaro.org>, berrange@redhat.com, 
	kchamart@redhat.com, pierrick.bouvier@oss.qualcomm.com, peter.maydell@linaro.org, 
	mst@redhat.com, cohuck@redhat.com, pbonzini@redhat.com, eblake@redhat.com, 
	armbru@redhat.com, lorenzo.pieralisi@linaro.org, qemu-devel@nongnu.org, 
	qemu-arm@nongnu.org, kvm@vger.kernel.org
Subject: Re: [RFC v2 01/24] linux-headers: Add RME related definitions
Message-ID: <amrq1_O7cOb8zk1Y@FCCLS0092175.localdomain>
References: <20260728192630.240375-1-mathieu.poirier@linaro.org>
 <20260728192630.240375-2-mathieu.poirier@linaro.org>
 <amrhioS_O_0ztjb_@FCCLS0092175.localdomain>
 <30967c8c-be29-49bb-b8fc-f4a3b870fed1@redhat.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <30967c8c-be29-49bb-b8fc-f4a3b870fed1@redhat.com>

On 07/30 16:08, Gavin Shan wrote:
> On 7/30/26 3:41 PM, Kohei Enju wrote:
> > On 07/28 13:26, Mathieu Poirier wrote:
> > > From: Jean-Philippe Brucker <jean-philippe@linaro.org>
> > > 
> > > This is a temporary patch intended for testing purposes only. It provides
> > > definitions related to supporting Realms by the QEMU-VMM.
> > > 
> > > Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
> > > Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
> > > ---
> > >   linux-headers/asm-arm64/kvm.h |  9 +++++++++
> > >   linux-headers/linux/kvm.h     | 10 +++++++++-
> > >   2 files changed, 18 insertions(+), 1 deletion(-)
> > > 
> > > diff --git a/linux-headers/asm-arm64/kvm.h b/linux-headers/asm-arm64/kvm.h
> > > index 6aefe7973814..4c08631ec7d2 100644
> > > --- a/linux-headers/asm-arm64/kvm.h
> > > +++ b/linux-headers/asm-arm64/kvm.h
> > > @@ -208,6 +208,15 @@ struct kvm_arm_counter_offset {
> > >   	__u64 reserved;
> > >   };
> > > +#define KVM_ARM_RMI_POPULATE_FLAGS_MEASURE     (1 << 0)
> > > +struct kvm_arm_rmi_populate {
> > > +	__u64 base;
> > > +	__u64 size;
> > > +	__u64 source_uaddr;
> > > +	__u32 flags;
> > > +	__u32 reserved;
> > > +};
> > > +
> > >   #define KVM_ARM_TAGS_TO_GUEST		0
> > >   #define KVM_ARM_TAGS_FROM_GUEST		1
> > > diff --git a/linux-headers/linux/kvm.h b/linux-headers/linux/kvm.h
> > > index dd52e2a65bfd..cdd5ad11f85a 100644
> > > --- a/linux-headers/linux/kvm.h
> > > +++ b/linux-headers/linux/kvm.h
> > > @@ -689,14 +689,19 @@ struct kvm_enable_cap {
> > >    * address size for the VM. Bits[7-0] are reserved for the guest
> > >    * PA size shift (i.e, log2(PA_Size)). For backward compatibility,
> > >    * value 0 implies the default IPA size, 40bits.
> > > + *
> > > + * Bits[30-31] are reserved for the VM type
> > >    */
> > >   #define KVM_VM_TYPE_ARM_IPA_SIZE_MASK	0xffULL
> > >   #define KVM_VM_TYPE_ARM_IPA_SIZE(x)		\
> > >   	((x) & KVM_VM_TYPE_ARM_IPA_SIZE_MASK)
> > > +#define KVM_VM_TYPE_ARM_NORMAL		0
> > > +#define KVM_VM_TYPE_ARM_REALM		(1UL << 30)
> > >   #define KVM_VM_TYPE_ARM_PROTECTED	(1UL << 31)
> > >   #define KVM_VM_TYPE_ARM_MASK		(KVM_VM_TYPE_ARM_IPA_SIZE_MASK | \
> > > -					 KVM_VM_TYPE_ARM_PROTECTED)
> > > +					 KVM_VM_TYPE_ARM_PROTECTED | \
> > > +					 KVM_VM_TYPE_ARM_REALM)
> > >   /*
> > >    * ioctls for /dev/kvm fds:
> > > @@ -719,6 +724,8 @@ struct kvm_enable_cap {
> > >   #define KVM_GET_EMULATED_CPUID	  _IOWR(KVMIO, 0x09, struct kvm_cpuid2)
> > >   #define KVM_GET_MSR_FEATURE_INDEX_LIST    _IOWR(KVMIO, 0x0a, struct kvm_msr_list)
> > > +#define KVM_ARM_RMI_POPULATE	  _IOWR(KVMIO, 0xd7, struct kvm_arm_rmi_populate)
> > > +
> > >   /*
> > >    * Extension capability list.
> > >    */
> > > @@ -986,6 +993,7 @@ struct kvm_enable_cap {
> > >   #define KVM_CAP_S390_KEYOP 247
> > >   #define KVM_CAP_S390_VSIE_ESAMODE 248
> > >   #define KVM_CAP_S390_HPAGE_2G 249
> > > +#define KVM_CAP_ARM_RMI 250
> > 
> > Not a big deal, but a note for anyone testing this series:
> > 
> > Use Linaro's Linux kernel tree, as mentioned in the cover letter:
> > https://gitlab.com/Linaro/cca-public/linux/-/tree/upstream-v2?ref_type=heads
> > 
> 
> It seems the capability values get an extra leap on KVM_CAP_ARM_AMI in
> "upstream-v2" host kernel.
> 
>   include/uapi/linux/kvm.h
> 
>   #define KVM_CAP_S390_KEYOP 247
>   #define KVM_CAP_S390_VSIE_ESAMODE 248
>   #define KVM_CAP_ARM_RMI 250

Yes. The following commit changed it in "upstream-v2".
https://gitlab.com/Linaro/cca-public/linux/-/commit/1558aa1d9b8a49283d69c15889cb2df98183d7d0

> 
> > Alternetively, if you're using Arm's tree or other trees with Steven
> > Price's v14 series as I am:
> > 
> > You'll need to adjust the definition of KVM_CAP_ARM_RMI, since it uses a
> > differenct capability number.
> > 
> > >   struct kvm_irq_routing_irqchip {
> > >   	__u32 irqchip;
> > > -- 
> > > 2.43.0
> > > 
> 
> Thanks,
> Gavin
> 
