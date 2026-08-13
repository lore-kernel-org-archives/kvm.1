Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19D3E368D62
	for <kvm@vger.kernel.org>; Thu, 13 Aug 2026 07:35:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786606529; cv=none; b=Ui8lMn8dsE2u7NFQVIrKH0lzp59l+4OoZcFOUkm408vYnptpNTq0PkoY0weZXinkvWH82+x/MlzejBYbnil+2Ya8OMoN+e+JG/P74W9p5TaaS78CNYDlC+jfqjNhC6/5lNeZAEWRDGoBdcdMWzaRTUfnmEzYkS5HUuJs6g1E0L0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786606529; c=relaxed/simple;
	bh=i6D+8ATMa5+5ErRcXrQOuqCk7EAd8/kW2z2iHgoQZ7w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=C+xQ0UvrWK/GDNxL7/CtDRzCtsDDdhhWDYwNAdwyyZYzSZOUyuPozP8kQwaCnZ9EX9pcW7XpUoiZarQzSrKPCeVD1TP1QFoD/YGTpI3BVxAsso9AnbsLBfjr9gTaXUxhOBKJKl/kJQgUf1gqiF7AEZ9rXUA7Pd2wnKRS2rWBapY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=iqGI6biK; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=hFkLVeuT; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=owFWtnMF; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=8oJpsy9O; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="iqGI6biK";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="hFkLVeuT";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="owFWtnMF";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="8oJpsy9O"
Received: from kunlun.suse.cz (unknown [IPv6:2a07:de40:b306:2000::2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id C99F13E6D;
	Thu, 13 Aug 2026 07:35:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1786606515; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+ohbpP4PWX0hIpf6SvEkZ4BNtZVxfmbgo05EbbLFYhw=;
	b=iqGI6biKSqg2QBAxper2lkTlKrcJBZpnQgfBROnMYrEv5dMRcZmdCKx/OCO4jGc2X6mJfS
	d59ho5LalGo9RHob2zCdIvA191Muf7iieCWRYsu4SK6HDiBFCh3qFQeg4bWPk4tfX4rhYL
	8THU3mpt4fnjwb/7koUaNpYpx2AGpjY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1786606515;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+ohbpP4PWX0hIpf6SvEkZ4BNtZVxfmbgo05EbbLFYhw=;
	b=hFkLVeuTB1LSSQxKQrDrYNw8dgWtAby7BJExZkje3yC8gcwW1q6Cvo6ojVMAJcBcST5rnX
	pm6VPTwBiyCPbxCw==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=owFWtnMF;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=8oJpsy9O
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1786606510; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+ohbpP4PWX0hIpf6SvEkZ4BNtZVxfmbgo05EbbLFYhw=;
	b=owFWtnMFiLLkxo4e+Xs3U+f70Atf2GY1mewfj+hZk2hBsadqgV4CGFI9YOru3KPYgf9i8g
	V+01bxeggG3OxM6ThvwgefmBk5xnBlYgv69vVq3fXO0UTnTcZ6fzXf81Hl5KBREXafOAYX
	eEPGmYeB5AoGDEqRon3K9WVa3TGno5o=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1786606510;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+ohbpP4PWX0hIpf6SvEkZ4BNtZVxfmbgo05EbbLFYhw=;
	b=8oJpsy9Oqz0wtQUanWzulF6mnGZZ4PdaCAseOPc18xUIFrJaKfQHMo9frCW49DKpuRpoFy
	Jv533hhl6wozJMBg==
Date: Thu, 13 Aug 2026 09:35:09 +0200
From: Michal =?iso-8859-1?Q?Such=E1nek?= <msuchanek@suse.de>
To: Amit Machhiwal <amachhiw@linux.ibm.com>
Cc: qemu-ppc@nongnu.org, Harsh Prateek Bora <harshpb@linux.ibm.com>,
	Vaibhav Jain <vaibhav@linux.ibm.com>,
	BALATON Zoltan <balaton@eik.bme.hu>,
	Anushree Mathur <anushree.mathur@linux.ibm.com>,
	Nicholas Piggin <npiggin@gmail.com>,
	Chinmay Rath <rathc@linux.ibm.com>,
	Glenn Miles <milesg@linux.ibm.com>,
	Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org,
	qemu-devel@nongnu.org, Gautam Menghani <gautam@linux.ibm.com>
Subject: Re: [PATCH v6 1/3] [DO_NOT_MERGE] linux-headers: Add uapi header
 changes
Message-ID: <an1zrUhbu_RYkJ-y@kunlun.suse.cz>
References: <20260812170854.58709-1-amachhiw@linux.ibm.com>
 <20260812170854.58709-2-amachhiw@linux.ibm.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260812170854.58709-2-amachhiw@linux.ibm.com>
X-Spamd-Result: default: False [15.15 / 50.00];
	SPAM_FLAG(5.00)[];
	NEURAL_SPAM_LONG(3.50)[1.000];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_SPAM_SHORT(2.96)[0.988];
	HFILTER_HOSTNAME_UNKNOWN(2.50)[];
	RDNS_NONE(2.00)[];
	ONCE_RECEIVED(1.20)[];
	HFILTER_HELO_IP_A(1.00)[kunlun.suse.cz];
	HFILTER_HELO_NORES_A_OR_MX(0.30)[kunlun.suse.cz];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_ZERO(0.00)[0];
	DKIM_TRACE(0.00)[suse.de:+];
	MISSING_XM_UA(0.00)[];
	FREEMAIL_CC(0.00)[nongnu.org,linux.ibm.com,eik.bme.hu,gmail.com,redhat.com,vger.kernel.org];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim]
X-Spam-Score: 15.15
X-Spam-Level: ***************
X-Spamd-Bar: +++++++++++++++
X-Rspamd-Queue-Id: C99F13E6D
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: YES
X-Rspamd-Action: add header
X-Spam: Yes

Hello,

some version of the kernel patches seems to be merged in the powerpc
tree now.

Cant his be merged now or is a refresh required?

Thanks

Michal

On Wed, Aug 12, 2026 at 10:38:52PM +0530, Amit Machhiwal wrote:
> This is a temporary patch intended for review and testing purposes only.
> It syncs the QEMU linux-headers with the kernel v9 changes that introduce
> the KVM_PPC_GET_COMPAT_CAPS ioctl for querying host CPU compatibility
> capabilities. The struct kvm_ppc_compat_caps places 'size' as the first
> field as required by copy_struct_from/to_user() versioning, with
> KVM_PPC_COMPAT_CAPS_SIZE_VER0 (24) defined as the frozen version-floor
> constant. The capability number is KVM_CAP_PPC_COMPAT_CAPS (250) and
> the ioctl is defined as _IO so the ioctl number remains stable if the
> struct grows in future versions. Capability bit definitions for POWER9,
> POWER10, and POWER11 compatibility modes are also included.
> 
> The actual header sync will be done via scripts/update-linux-headers.sh
> once the kernel changes [1] are merged upstream.
> 
> [1] https://lore.kernel.org/all/20260808161148.66673-1-amachhiw@linux.ibm.com/
> 
> Tested-by: Gautam Menghani <gautam@linux.ibm.com>
> Reviewed-by: Gautam Menghani <gautam@linux.ibm.com>
> Tested-by: Anushree Mathur <anushree.mathur@linux.ibm.com>
> Signed-off-by: Amit Machhiwal <amachhiw@linux.ibm.com>
> ---
> No changes in this version.
> 
>  linux-headers/asm-powerpc/kvm.h | 19 +++++++++++++++++++
>  linux-headers/linux/kvm.h       |  3 +++
>  2 files changed, 22 insertions(+)
> 
> diff --git a/linux-headers/asm-powerpc/kvm.h b/linux-headers/asm-powerpc/kvm.h
> index 077c5437f521..2c229fe0562c 100644
> --- a/linux-headers/asm-powerpc/kvm.h
> +++ b/linux-headers/asm-powerpc/kvm.h
> @@ -437,6 +437,25 @@ struct kvm_ppc_cpu_char {
>  	__u64	behaviour_mask;		/* valid bits in behaviour */
>  };
>  
> +/* For KVM_PPC_GET_COMPAT_CAPS */
> +struct kvm_ppc_compat_caps {
> +	__u64	size;			/* Size of this structure */
> +	__u64	flags;			/* Reserved for future use */
> +	__u64	compat_capabilities;	/* Capabilities supported by the host */
> +};
> +#define KVM_PPC_COMPAT_CAPS_SIZE_VER0	24 /* sizeof first published struct */
> +
> +/*
> + * Capability bits for compat_capabilities field in kvm_ppc_compat_caps.
> + * These bits indicate which processor compatibility modes are supported.
> + */
> +#define KVM_PPC_COMPAT_CAP_POWER9	(1ULL << 62)
> +#define KVM_PPC_COMPAT_CAP_POWER10	(1ULL << 61)
> +#define KVM_PPC_COMPAT_CAP_POWER11	(1ULL << 60)
> +#define KVM_PPC_COMPAT_BITMASK		(KVM_PPC_COMPAT_CAP_POWER9 | \
> +					 KVM_PPC_COMPAT_CAP_POWER10 | \
> +					 KVM_PPC_COMPAT_CAP_POWER11)
> +
>  /*
>   * Values for character and character_mask.
>   * These are identical to the values used by H_GET_CPU_CHARACTERISTICS.
> diff --git a/linux-headers/linux/kvm.h b/linux-headers/linux/kvm.h
> index dd52e2a65bfd..aea4ab5c6953 100644
> --- a/linux-headers/linux/kvm.h
> +++ b/linux-headers/linux/kvm.h
> @@ -986,6 +986,7 @@ struct kvm_enable_cap {
>  #define KVM_CAP_S390_KEYOP 247
>  #define KVM_CAP_S390_VSIE_ESAMODE 248
>  #define KVM_CAP_S390_HPAGE_2G 249
> +#define KVM_CAP_PPC_COMPAT_CAPS 250
>  
>  struct kvm_irq_routing_irqchip {
>  	__u32 irqchip;
> @@ -1330,6 +1331,8 @@ struct kvm_s390_keyop {
>  /* Available with KVM_CAP_COUNTER_OFFSET */
>  #define KVM_ARM_SET_COUNTER_OFFSET _IOW(KVMIO,  0xb5, struct kvm_arm_counter_offset)
>  #define KVM_ARM_GET_REG_WRITABLE_MASKS _IOR(KVMIO,  0xb6, struct reg_mask_range)
> +/* Available with KVM_CAP_PPC_COMPAT_CAPS */
> +#define KVM_PPC_GET_COMPAT_CAPS	_IO(KVMIO,  0xb8)
>  
>  /* ioctl for vm fd */
>  #define KVM_CREATE_DEVICE	  _IOWR(KVMIO,  0xe0, struct kvm_create_device)
> -- 
> 2.50.1 (Apple Git-155)
> 
> 
