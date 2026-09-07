Received: from mail.8bytes.org (mail.8bytes.org [85.214.250.239])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44640479879
	for <kvm@vger.kernel.org>; Mon,  7 Sep 2026 13:15:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.250.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788786932; cv=none; b=BXIZInYyHDW50fBYDFzoLKjuWEEdtGs9uSapiiEF0iRJBaAba56J74ASKIAjSf3NNcXjCGoWmaPKKLvO/TSJWEO5CqYB7O/jBYepEdTmLgMtCYyPerbvDu3btzMT8nq1u82J9zjWTGqvhsa/5EsbF22Ol2TM3XYBHxL7NgJjELw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788786932; c=relaxed/simple;
	bh=RhNGDVrXfdi8Pn0s/Hg6mrH+uFKg6viyeLXPqYERh/c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZcjWY1OWUc2BwQRG0wRCKctmHloAAU59vEZZQekkTRVVbW2ruz8SoPhaMD4OehMXs1Y6LdImqN862Sf3ZwhqS/iDdnxM29t9gUrTe8RTL2OGDWENeDz4KUGbt/KB1wtw1K6zHp6mwSffcbsQ4ZVmxcJ1Ipcv8FFV8gfIdkqJHZk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org; spf=pass smtp.mailfrom=8bytes.org; arc=none smtp.client-ip=85.214.250.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=8bytes.org
Received: from 8bytes.org (p200300f6af085a0015db8e28914752a6.dip0.t-ipconnect.de [IPv6:2003:f6:af08:5a00:15db:8e28:9147:52a6])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.8bytes.org (Postfix) with ESMTPSA id 57FF7209F7F;
	Mon,  7 Sep 2026 15:15:22 +0200 (CEST)
Date: Mon, 7 Sep 2026 15:15:21 +0200
From: =?utf-8?B?SsO2cmcgUsO2ZGVs?= <joro@8bytes.org>
To: Tony Lindgren <tony.lindgren@linux.intel.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, 
	Sean Christopherson <seanjc@google.com>, Peter Xu <peterx@redhat.com>, 
	Artem Bityutskiy <artem.bityutskiy@linux.intel.com>, Fabiano Rosas <farosas@suse.de>, Jon Grimm <Jon.Grimm@amd.com>, 
	Pankaj Gupta <pankaj.gupta@amd.com>, Tom Lendacky <thomas.lendacky@amd.com>, 
	Marc Zyngier <maz@kernel.org>, Oliver Upton <oliver.upton@linux.dev>, 
	Steven Price <steven.price@arm.com>, Anup Patel <anup@brainfault.org>, 
	Samuel Ortiz <sameo@rivosinc.com>, Jakub =?utf-8?B?UsWvxb5pxI1rYQ==?= <jakub.ruzicka@matfyz.cz>, 
	Vishal Annapurve <vannapurve@google.com>, Elena Reshetova <elena.reshetova@intel.com>, 
	Kai Huang <kai.huang@intel.com>, Kishen Maloor <kishen.maloor@intel.com>, 
	Mika Westerberg <mika.westerberg@linux.intel.com>, Peter Fang <peter.fang@intel.com>, 
	Rick Edgecombe <rick.p.edgecombe@intel.com>, Xiaoyao Li <xiaoyao.li@intel.com>, 
	Xu Yilun <yilun.xu@linux.intel.com>, kvm@vger.kernel.org
Subject: Re: [RFC PATCH v2 2/4] KVM: x86: Add optional KVM_CAP_LIVE_MIGRATION
 and KVM_MIGRATE_CMD
Message-ID: <ap64dFXpiDb_Hqxl@8bytes.org>
References: <20260831071304.762939-1-tony.lindgren@linux.intel.com>
 <20260831071304.762939-3-tony.lindgren@linux.intel.com>
 <ap6loazXtvSCqmpR@tlindgre-MOBL1>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ap6loazXtvSCqmpR@tlindgre-MOBL1>

On Mon, Sep 07, 2026 at 02:53:05PM +0300, Tony Lindgren wrote:
> On Mon, Aug 31, 2026 at 10:13:02AM +0300, Tony Lindgren wrote:
> > --- a/include/uapi/linux/kvm.h
> > +++ b/include/uapi/linux/kvm.h
> > @@ -1670,4 +1673,23 @@ struct kvm_pre_fault_memory {
> >  	__u64 padding[5];
> >  };
> >  
> > +#define KVM_MIGRATE_SETUP		0
> > +#define KVM_MIGRATE_ITERATION		1
> > +#define KVM_MIGRATE_STOP_AND_COPY	2
> > +#define KVM_MIGRATE_ABORT		3
> > +#define KVM_MIGRATE_END			4
> > +
> > +struct kvm_transfer_buffer {
> > +	__u64 address;
> > +	__u32 size;
> > +	__u32 reserved;
> > +};
> > +
> > +struct kvm_migrate_cmd {
> > +	__u16 command;
> > +	__u16 flags;
> > +	__u32 reserved;
> > +	struct kvm_transfer_buffer buf;
> > +};
> 
> For the common flags, KVM_MIGRATE_CMD probably should have migration
> direction. Or maybe we could have KVM_EXPORT_CMD and KVM_IMPORT_CMD.

The direction is always the same over a single live migration session, right?
So it could be a setup flag, on the other hand having separate KVM_EXPORT_CMD
and KVM_IMPORT_CMD seems to be a cleaner ABI.


-Joerg
