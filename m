Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA910375F82;
	Tue, 17 Mar 2026 09:47:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773740876; cv=none; b=NpTtLU1hTAnXecZd0Mf8HczxhK94eNQZpmka0quKe3Tjq/sh6EquSDdYYRY7sSB4ltjqKgksSuQXyiHxq8fr0D7150TrSMKPjNxMNOsI2NhtHNzJSyUiM6hlSJU73fYWZVvA980Nc5T9OTkBpVfLO/pgZ8olQnJl1Sw2+G4SYuQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773740876; c=relaxed/simple;
	bh=ENV4IiBEinpafj1cuTSE243f5d7APa/mGbcOZw2N3Tk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Bfa74steUe5HaooqRuHqW6nibIMukqON1D99DuNiluyEXoCwnUqbxzae+DhqHCka5lo2UcL1rWIc7Dm/kdG8CnvYVOHzu2VkZBiyfkaMzHyU0Jsv45mg+jNB9R4UjpV/pu2YX1OOdfgecoaI+qex2yuPawF8EUuP3EHg3H3Xt6o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JBG2KKA3; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JBG2KKA3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF263C4CEF7;
	Tue, 17 Mar 2026 09:47:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773740876;
	bh=ENV4IiBEinpafj1cuTSE243f5d7APa/mGbcOZw2N3Tk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=JBG2KKA3gFT8Fv9RA0u2OcGyNPGR11JYNv/BQ6Lz9lftHxK8G7038BA280neS3JH4
	 fYmJGsUAg0X/0N7XP42ZywxFcH9ofHeRlI1zxSQKPBtSLR10pYUzQ05wfBGmm3kqhs
	 Tglch8F2boGBvuvVxXR6nOFX5kQ+8spP/0EwZ6rF1ZGd68dA4R5XtJ8wRNM2qjGLh2
	 srBFbp7sGENMwOhjznMxJCg5wj2YiQ1DGbRnuRFIk72XJ+79zTLGPFagpsg7m65s5P
	 ZWvEjhRjY/T3xRgn44vvLdkXD32G2pV7Mxle5F0b3Wn2IsOn9JoXOWuHTO72yjzRCA
	 zPXytZ8Wek9Ig==
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfauth.phl.internal (Postfix) with ESMTP id D2C19F40071;
	Tue, 17 Mar 2026 05:47:54 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Tue, 17 Mar 2026 05:47:54 -0400
X-ME-Sender: <xms:SiO5abBx4sbGK9rQ1afGQb3gkWWNaE5fZI-FCPsBXuUXwRBeuts9Og>
    <xme:SiO5aT0syCuLarb5a78BiqmXC5tDrAAMmyAYWGE8z1JFxNyeQgHQFzCVS2SxIUE9s
    Q_B9vkgnDce9rMRaVfmqAyNoUJpxy8dykELBa78KncniyTim0hkqYw>
X-ME-Received: <xmr:SiO5aVQBCUeyrfve4eYt-CyrxJ99lj0cOeKiPNHrc_Nfk_wIaIK264U-FWiINQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdeftddtleefucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggugfgjsehtkeortddttddunecuhfhrohhmpefmihhrhihl
    ucfuhhhuthhsvghmrghuuceokhgrsheskhgvrhhnvghlrdhorhhgqeenucggtffrrghtth
    gvrhhnpeefheegleevkeeghedvieduvddtjeeujedvveevhfehteehheeuteefkeekueel
    leenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehkih
    hrihhllhdomhgvshhmthhprghuthhhphgvrhhsohhnrghlihhthidqudeiudduiedvieeh
    hedqvdekgeeggeejvdekqdhkrghspeepkhgvrhhnvghlrdhorhhgsehshhhuthgvmhhovh
    drnhgrmhgvpdhnsggprhgtphhtthhopeefvddpmhhouggvpehsmhhtphhouhhtpdhrtghp
    thhtoheprhhitghkrdhprdgvughgvggtohhmsggvsehinhhtvghlrdgtohhmpdhrtghpth
    htohepthhglhigsehkvghrnhgvlhdrohhrghdprhgtphhtthhopegurghvvgdrhhgrnhhs
    vghnsehinhhtvghlrdgtohhmpdhrtghpthhtohepshgvrghnjhgtsehgohhoghhlvgdrtg
    homhdprhgtphhtthhopegsphesrghlihgvnhekrdguvgdprhgtphhtthhopeigkeeisehk
    vghrnhgvlhdrohhrghdprhgtphhtthhopegrtghkvghrlhgvhihtnhhgsehgohhoghhlvg
    drtghomhdprhgtphhtthhopehhphgrseiihihtohhrrdgtohhmpdhrtghpthhtoheplhhi
    nhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:SiO5aasepOB4D8JLlvMGHtqf-eBSptKMe_Y3-p26BBMjmSDBgYW-_g>
    <xmx:SiO5ad7No0aHFAmQx91FKslDAHyFlEmuytZwKbDTvl2GvvCzQKDn4Q>
    <xmx:SiO5aYbLK7uOzJIXua8WYkr10Xi5n-eCQ1jJ9eOOBju2kX6a_f0Kyw>
    <xmx:SiO5aQgifegbxvPjYJmfCmdpPfZIK9yPGEXkzWLLsmx6lLJuyJ6hCA>
    <xmx:SiO5aTaVq1dVv_kS77sdAA3bfiHmIQ0rAnsgMxKgi7XatQ32PmKLptJi>
Feedback-ID: i10464835:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 17 Mar 2026 05:47:52 -0400 (EDT)
Date: Tue, 17 Mar 2026 09:47:46 +0000
From: Kiryl Shutsemau <kas@kernel.org>
To: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
Cc: "tglx@kernel.org" <tglx@kernel.org>, 
	"Hansen, Dave" <dave.hansen@intel.com>, "seanjc@google.com" <seanjc@google.com>, 
	"bp@alien8.de" <bp@alien8.de>, "x86@kernel.org" <x86@kernel.org>, 
	"ackerleytng@google.com" <ackerleytng@google.com>, "hpa@zytor.com" <hpa@zytor.com>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "mingo@redhat.com" <mingo@redhat.com>, 
	"Huang, Kai" <kai.huang@intel.com>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>, 
	"linux-coco@lists.linux.dev" <linux-coco@lists.linux.dev>, "pbonzini@redhat.com" <pbonzini@redhat.com>, 
	"Verma, Vishal L" <vishal.l.verma@intel.com>, "Gao, Chao" <chao.gao@intel.com>
Subject: Re: [PATCH 3/4] x86/virt/tdx: Add SEAMCALL wrapper for
 TDH.SYS.DISABLE
Message-ID: <abkdNQnvgJWmaKWk@thinkstation>
References: <20260307010358.819645-1-rick.p.edgecombe@intel.com>
 <20260307010358.819645-4-rick.p.edgecombe@intel.com>
 <abftAJkiU3Q24wYQ@thinkstation>
 <ac341cedf0e387f2ba5cf3fc9d2ad5fcaa2ec3c8.camel@intel.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ac341cedf0e387f2ba5cf3fc9d2ad5fcaa2ec3c8.camel@intel.com>

On Mon, Mar 16, 2026 at 09:15:13PM +0000, Edgecombe, Rick P wrote:
> On Mon, 2026-03-16 at 11:51 +0000, Kiryl Shutsemau wrote:
> > On Fri, Mar 06, 2026 at 05:03:57PM -0800, Rick Edgecombe wrote:
> > > From: Vishal Verma <vishal.l.verma@intel.com>
> > > 
> > > Some early TDX-capable platforms have an erratum where a partial write
> > > to TDX private memory can cause a machine check on a subsequent read.
> > > On these platforms, kexec and kdump have been disabled in these cases,
> > > because the old kernel cannot safely hand off TDX state to the new
> > > kernel. Later TDX modules support the TDH.SYS.DISABLE SEAMCALL, which
> > > provides a way to cleanly disable TDX and allow kexec to proceed.
> > 
> > Does it need to be enumerated?
> > 
> > I don't see this SEAMCALL be covered in the public documentation.
> > </me looking around>
> > Ah! Found it the the draft. So the feature is not yet finalized.
> > 
> > "Support of TDH.SYS.DISABLE is enumerated by TDX_FEATURES0. SYS_DISABLE
> > (bit 53)"
> > 
> > I am seeing the next patch calling it unconditionally. Is it okay?
> 
> We debated checking the feature bit before allowing kexec, but decided it was
> simpler to just blindly call and ignore the errors. The reasoning was that this
> is already a somewhat exotic scenario being addressed, and future modules will
> have the feature. So maintaining a check for the feature bit only helps a little
> bit, for a short time. And then only if the user would rather have kexec blocked
> than attempt it. Do you think it is worth it?

No, I see very limited reason to support stale TDX modules. Users are
expected to keep the module up-to-date, so skipping enumeration should
be okay. But it deserves explanation in the commit message or a comment.

> > > This can be a long running operation, and the time needed largely
> > > depends on the amount of memory that has been allocated to TDs. If all
> > > TDs have been destroyed prior to the sys_disable call, then it is fast,
> > > with only needing to override the TDX module memory.
> > > 
> > > After the SEAMCALL completes, the TDX module is disabled and all memory
> > > resources allocated to TDX are freed and reset. The next kernel can then
> > > re-initialize the TDX module from scratch via the normal TDX bring-up
> > > sequence.
> > > 
> > > The SEAMCALL may be interrupted by an interrupt. In this case, it
> > > returns TDX_INTERRUPTED_RESUMABLE, and it must be retried in a loop
> > > until the operation completes successfully.
> > > 
> > > Add a tdx_sys_disable() helper, which implements the retry loop around
> > > the SEAMCALL to provide this functionality.
> > > 
> > > Signed-off-by: Vishal Verma <vishal.l.verma@intel.com>
> > > Signed-off-by: Rick Edgecombe <rick.p.edgecombe@intel.com>
> > > ---
> > >   arch/x86/include/asm/tdx.h  |  3 +++
> > >   arch/x86/virt/vmx/tdx/tdx.c | 18 ++++++++++++++++++
> > >   arch/x86/virt/vmx/tdx/tdx.h |  1 +
> > >   3 files changed, 22 insertions(+)
> > > 
> > > diff --git a/arch/x86/include/asm/tdx.h b/arch/x86/include/asm/tdx.h
> > > index f0826b0a512a..baaf43a09e99 100644
> > > --- a/arch/x86/include/asm/tdx.h
> > > +++ b/arch/x86/include/asm/tdx.h
> > > @@ -173,6 +173,8 @@ static inline int pg_level_to_tdx_sept_level(enum pg_level level)
> > >           return level - 1;
> > >   }
> > >   
> > > +void tdx_sys_disable(void);
> > > +
> > >   u64 tdh_vp_enter(struct tdx_vp *vp, struct tdx_module_args *args);
> > >   u64 tdh_mng_addcx(struct tdx_td *td, struct page *tdcs_page);
> > >   u64 tdh_mem_page_add(struct tdx_td *td, u64 gpa, struct page *page, struct page *source, u64 *ext_err1, u64 *ext_err2);
> > > @@ -204,6 +206,7 @@ static inline void tdx_init(void) { }
> > >   static inline u32 tdx_get_nr_guest_keyids(void) { return 0; }
> > >   static inline const char *tdx_dump_mce_info(struct mce *m) { return NULL; }
> > >   static inline const struct tdx_sys_info *tdx_get_sysinfo(void) { return NULL; }
> > > +static inline void tdx_sys_disable(void) { }
> > >   #endif	/* CONFIG_INTEL_TDX_HOST */
> > >   
> > >   #endif /* !__ASSEMBLER__ */
> > > diff --git a/arch/x86/virt/vmx/tdx/tdx.c b/arch/x86/virt/vmx/tdx/tdx.c
> > > index 0802d0fd18a4..68bd2618dde4 100644
> > > --- a/arch/x86/virt/vmx/tdx/tdx.c
> > > +++ b/arch/x86/virt/vmx/tdx/tdx.c
> > > @@ -37,6 +37,7 @@
> > >   #include <asm/msr.h>
> > >   #include <asm/cpufeature.h>
> > >   #include <asm/tdx.h>
> > > +#include <asm/shared/tdx_errno.h>
> > >   #include <asm/cpu_device_id.h>
> > >   #include <asm/processor.h>
> > >   #include <asm/mce.h>
> > > @@ -1940,3 +1941,20 @@ u64 tdh_phymem_page_wbinvd_hkid(u64 hkid, struct page *page)
> > >   	return seamcall(TDH_PHYMEM_PAGE_WBINVD, &args);
> > >   }
> > >   EXPORT_SYMBOL_FOR_KVM(tdh_phymem_page_wbinvd_hkid);
> > > +
> > > +void tdx_sys_disable(void)
> > > +{
> > > +	struct tdx_module_args args = {};
> > > +
> > > +	/*
> > > +	 * SEAMCALLs that can return TDX_INTERRUPTED_RESUMABLE are guaranteed
> > > +	 * to make forward progress between interrupts, so it is safe to loop
> > > +	 * unconditionally here.
> > > +	 *
> > > +	 * This is a 'destructive' SEAMCALL, in that no other SEAMCALL can be
> > > +	 * run after this until a full reinitialization is done.
> > > +	 */
> > > +	while (seamcall(TDH_SYS_DISABLE, &args) == TDX_INTERRUPTED_RESUMABLE)
> > > +		;
> > 
> > Silently ignore any other errors?
> 
> Do you think it's worth a warn? There are a couple other considerations.
>   - Kai brought up offline that we should handle TDX_SYS_BUSY here too.
>   - Previous kexec patches had trouble solving races around tdx enabling. So we
> have to handle the seamcall failures.
> 
> So we have to exclude a few different errors in different ways. And then the
> warn worthy error codes either don't impact anything, or the new kernel will
> fail to initialize the TDX module and give notice there.

The delayed error is harder to debug. It can be useful to leave a
breadcrumbs.

Also, do we want to make try_init_module_global() return failure after
tdx_sys_disable()? I guess, TDH_SYS_LP_INIT will fail anyway, so it
shouldn't matter.

-- 
  Kiryl Shutsemau / Kirill A. Shutemov
