Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6D3F3B6C13
	for <kvm@vger.kernel.org>; Fri, 16 Oct 2026 23:26:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792193195; cv=none; b=RS1HRLpqhkTKgebVnrfcw34tgBbFfMA6hD1vCODq0HR2N/nqcEsJKCWlBoEzZE4yaL8kubUoZO5mNICjbQU3qplyh4UHRzUBHECIZ7886ueMyVCjNDF7Cyma77CaCt/oZf2YpNvMdN2XZ03AqbPCu4YasGmD6+PXKyvVkiO54y4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792193195; c=relaxed/simple;
	bh=iabWN3oL0XkeyL00qg44hU829wpjFAZwwywLXjRCDSk=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=DsKqcry4qDoYk9z1+OEO1Wx+LUJ6llRfcfe+Rc+CmjBVt7wKqSvRtF4tRd9V0nNMwpbcROif2TKCMCHrDyHC9fB0E4m80XnBeHiaP0kKp49V2+ucMTE180WuSXSYsy/W52jChTgqpcAgwsDevpfd9boeTBJrQh7wgMlrh49acUc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=rElXsDPf; arc=none smtp.client-ip=209.85.216.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="rElXsDPf"
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-3a47617a0b3so471528a91.2
        for <kvm@vger.kernel.org>; Fri, 16 Oct 2026 16:26:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1792193190; x=1792797990; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=vdrF8tneK2f5AV7WlOd7orm0K4PAGpMBHCQ0RAeUzXs=;
        b=rElXsDPfM5eWEzSBNtKE51kACOaGOETK1Wh2AWm+VWXSRSVIjOybJgd04qxDr4uks8
         bA3vVXoUcD3mJh6WZvowKXatZyAXs13ew5ec3DKffpTVVCGaeWL+fE2X0jt2qJvcRtZS
         X/jBNa3Qiao661wJfdpJdVwnL9neUR0PdtmVS8WcCiRjUVNCQkijDybfRPQQY7FgzlyJ
         rWLwmKf7zUKOdk7e30te91h0fGOzzGPerjNZOG8T4rqLxnu8yXr+YF92OBC+wFEPXG88
         5ImUfMoIqS6oF+qINg51ts3p6lBxcW2WBUt8VQCkJimbtfOP5CTQnNpdHUC0NCBvmT97
         REyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792193190; x=1792797990;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=vdrF8tneK2f5AV7WlOd7orm0K4PAGpMBHCQ0RAeUzXs=;
        b=ndWn8hSz/b8R08JZ7w9hrE7hRKnNspZFP7QwGPbnWGrxzagQJsdocWnx1g/62y2AP5
         l2na8MLdRggA7a1rcAs6ZBc6lozZ8tNkyqywh/tCXJGekEypV4ienVV8BSj4rAKqm0VN
         ONZ9MEVVnHLE42zyHMrNBiTbGf99XQQXorWqPdRWNeFtkUXGi7fa6A834iw0apaBvZkF
         QR38SM9Txmwrn8NswdTofP+OKS8eNM8Ehw2IJ5tmNkoJiXSMoChjqs+f778mqKP7fWa8
         FsVoAAMlbnCSMy2tcPO+toPmAlq5gj8d4LmMWsKR+oQiIShT5xeu8LiDWGm1n6S7xdAb
         gTnw==
X-Forwarded-Encrypted: i=1; AKwUvBwDNQuRLHUAR/IoRN+Gfnbnv/dUJ7s62oVZwOzb88Y2wOXGnyAE/ZnktqfN7tSw1OTS7ZQ=@vger.kernel.org
X-Gm-Message-State: AFq9FYK3Q5G0qntZGUXH2SMbI4d11xdQAb16nDD778J7hrghBKSFE8Cd
	7oxNfHRdRAFyz9H5E5ABJADtyzSMkWw3FJ8brFzGjbRzhzWI0WAh08gWDDuA78CXzA2j+DTCBfC
	wy5bkUg==
X-Received: from pgjo8.prod.google.com ([2002:a63:e348:0:b0:cd6:24a5:fd])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:5745:b0:3ac:9706:7735
 with SMTP id 98e67ed59e1d1-3acee277174mr1186652a91.5.1792193189278; Fri, 16
 Oct 2026 16:26:29 -0700 (PDT)
Date: Fri, 16 Oct 2026 16:26:28 -0700
In-Reply-To: <e1553e03-7ca8-4507-b608-d9d663759c1f@linux.intel.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20261016091422.3182216-1-binbin.wu@linux.intel.com>
 <20261016091422.3182216-2-binbin.wu@linux.intel.com> <atJB7kDzKsvzrMau@google.com>
 <e1553e03-7ca8-4507-b608-d9d663759c1f@linux.intel.com>
Message-ID: <atKypOb2h87evCY5@google.com>
Subject: Re: [PATCH v5 1/5] KVM: TDX: Check unsupported CPUID bits against the
 TDX module's subleaf
From: Sean Christopherson <seanjc@google.com>
To: Binbin Wu <binbin.wu@linux.intel.com>
Cc: linux-kernel@vger.kernel.org, kvm@vger.kernel.org, pbonzini@redhat.com, 
	dave.hansen@linux.intel.com, andrew.cooper3@citrix.com, nik.borisov@suse.com, 
	kas@kernel.org, rick.p.edgecombe@intel.com, xiaoyao.li@intel.com, 
	chao.gao@intel.com, tony.lindgren@linux.intel.com, kishen.maloor@intel.com, 
	dedekind1@gmail.com, adrian.hunter@intel.com
Content-Type: text/plain; charset="us-ascii"

On Sat, Oct 17, 2026, Binbin Wu wrote:
> On 10/16/2026 11:25 PM, Sean Christopherson wrote:
> > On Fri, Oct 16, 2026, Binbin Wu wrote:
> > @@ -2386,7 +2390,7 @@ static int setup_tdparams_cpuids(struct kvm_cpuid2 *cpuid,
> >                 if (!entry)
> >                         continue;
> >  
> > -               if (tdx_unsupported_cpuid(entry))
> > +               if (tdx_is_unsupported_cpuid_entry(entry))
> >                         return -EINVAL;
> >  
> >                 copy_cnt++;
> > 
> > Can you test the attached patches?  If they boot TDX with QEMU, I'll go ahead
> > and post.
> 
> Patch 3 "KVM: TDX: Don't zero non-significant CPUID entry indices" breaks QEMU.
> 
> QEMU uses zero as index for cpuid entries when index is not significant.

Drat.  __do_cpuid_func() => do_host_cpuid() also zeros the index for
KVM_GET_SUPPORTED_CPUID, so the ABI is definitely baked at this point. 

> And in QEMU, the lookup function doesn't consult the flags at all.
> 
> struct kvm_cpuid_entry2 *cpuid_find_entry(struct kvm_cpuid2 *cpuid,
>                                           uint32_t function,
>                                           uint32_t index)
> {
>     int i;
>     for (i = 0; i < cpuid->nent; ++i) {
>         if (cpuid->entries[i].function == function &&
>             cpuid->entries[i].index == index) {

Bad QEMU, bad!  :-)

>             return &cpuid->entries[i];
>         }
>     }
>     /* not found: */
>     return NULL;
> }
> 
> If KVM doesn't zero the index for the non-significant, QEMU cannot find
> any entry for non-significant entries returned by KVM_TDX_CAPABILITIES.

I'll opportunistically add a comment to call out that even though the index
should be meaningless, it has become ABI that userspace relies on.

> And 0x80000008 is used to pass GPAW, and KVM_TDX_INIT_VM fails when QEMU
> doesn't pass it.
> 
> After dropping patch 3, QEMU can boot TD.
> Also our internal TDX CI cases passed.

Thanks much!
