Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A362C1A3172
	for <kvm@vger.kernel.org>; Fri, 10 Apr 2026 15:49:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775836146; cv=none; b=bIfAhm6ASxxmPokdGWGsNDKIICUJyOd5LNzjPBn2A0aeWKiyoUePXDA+DV6abLohpsW7N/MOx+yPgRyR7yYeYSk5j+n+A1mPjnZZ5kkiL9+oRHrFdHIRtxBWpR2JELowTccLlwhH+L9GQg1zmfMMuOUFRDZSsaNNmY13d8ZKssk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775836146; c=relaxed/simple;
	bh=xmi2+Ys7yjCGVp3E9lCJ58hS3LUvnrIEni0UY3q/vLY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=BDAg4X9ARQTOQwJgLGyChbcPmCAkeFCf+dRMndtKtBuULyBPxp3ERh8v9diZQrNHS4oSuKCOTuQuIr6yF7b4+vEySCbP+sYcBP+NrOF3AtWbsVrjVwdSBXzylYPIEoJcT6eKX1cXERXVm0EvhUGWPGXhPsFRUI7scePmB5FAmms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=gFnqaRtV; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="gFnqaRtV"
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-b62da7602a0so1577189a12.2
        for <kvm@vger.kernel.org>; Fri, 10 Apr 2026 08:49:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1775836145; x=1776440945; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=faJrPe5E1iOOz0a/gpgWm74oLvXOv4P7sGEqr654TnI=;
        b=gFnqaRtVRhvTfGC+AtpfuDC7lb9rmgcbo17FW4PMLQH8KW0M8jrWxnTys1V1/vxjWc
         +YpdAhtYtcS5up22H7svjB8FUkxfjEHzsricWes9EjCQ9Uc2hX3GVSsbKKN4BG3n8PLC
         JekFAUU25E/BoWU8OWtIQrTGzXQ8I5BoqjEzGCsnUiHGCcbvnkIZ00UkqgD2xG4j7xUm
         iieBaCIo+3qUAavIaCvxvmWSN29s2/7Um8/omE+VLFya/RP/4g46dpWYYQR12J1qEAeF
         lu05I+W98oPZTrst7zpZiwjf8aUR/h06L0NK5G4pT8ivdJa22PLYs9Ne5313jh90OkhH
         X/RQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775836145; x=1776440945;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=faJrPe5E1iOOz0a/gpgWm74oLvXOv4P7sGEqr654TnI=;
        b=FhOQPFISvYX4crEtpjR0HINdlBP6FCYxMRXc0NP+Jh+wmQkuRs4YaEK0coCqa+UA9x
         LE1Vcs6kgZx4cxBMU7Jl2RGiQjr8Yn391m+W5H9EYSYBOooLf3dOqxa+ALQ0qetGQswZ
         UCFaMmroSNNqbREogdpg8GsCNBKVz0re3CwrUyScVYaYESl7UxpoJSE/jyJzvYbRjZg5
         DvRRNMrh4ZgwsidoeC0VGQPU0W4vN7uEqxa5C2n+pz4m0NGdKtO6M46j9mMJphEZiBsi
         o5NhjSJnWnMOnXavQtlXqyE90sIrOC10fl/trLEjjVnGubIAo96JrSPNk8VISA4q+DNK
         UIDw==
X-Forwarded-Encrypted: i=1; AJvYcCXqynzohaKwuL8+6eXDAABMx+hJfP8LBJ4sFmJ0OfRsP4snJNOtfDxdkR/i71BVSvCDho8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzlBVysvYuOCVOmp2CAMsgjJPx6cxaaKbuon5cp7gLLax9lVJ/K
	FUpbJ1bvoqEZAVT3IFbEVUFqUNry08UC3SxXP8mbFzuJ96V0DYuxX1OK1tw9asYi02SnLAxeZfp
	t+8hAUQ==
X-Received: from pgct16.prod.google.com ([2002:a05:6a02:5290:b0:c76:6b2a:2e00])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:e210:b0:398:8546:c3fc
 with SMTP id adf61e73a8af0-39fe3c62aeamr4154102637.7.1775836144846; Fri, 10
 Apr 2026 08:49:04 -0700 (PDT)
Date: Fri, 10 Apr 2026 08:49:03 -0700
In-Reply-To: <adiq6GTAhbVubEg/@yzhao56-desk.sh.intel.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260310234829.2608037-1-seanjc@google.com> <20260310234829.2608037-13-seanjc@google.com>
 <adc1IrD8uqWdaOKv@yzhao56-desk.sh.intel.com> <adf0fHP8sSk6j9G4@google.com> <adiq6GTAhbVubEg/@yzhao56-desk.sh.intel.com>
Message-ID: <adkb77KphASc9uwa@google.com>
Subject: Re: [PATCH 12/21] KVM: SEV: WARN on unhandled VM type when
 initializing VM
From: Sean Christopherson <seanjc@google.com>
To: Yan Zhao <yan.y.zhao@intel.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Jethro Beekman <jethro@fortanix.com>, Alexander Potapenko <glider@google.com>, 
	"Carlos =?utf-8?B?TMOzcGV6?=" <clopez@suse.de>
Content-Type: text/plain; charset="us-ascii"

On Fri, Apr 10, 2026, Yan Zhao wrote:
> On Thu, Apr 09, 2026 at 11:48:28AM -0700, Sean Christopherson wrote:
> > On Thu, Apr 09, 2026, Yan Zhao wrote:
> > > On Tue, Mar 10, 2026 at 04:48:20PM -0700, Sean Christopherson wrote:
> > > > +	default:
> > > > +		WARN_ONCE(1, "Unsupported VM type %lu", kvm->arch.vm_type);
> > > After pulling the latest kvm-x86/next, I encountered this compilation warning:
> > > "arch/x86/kvm/svm/sev.c:2954:30: error: format %lu expects argument of type long
> > > unsigned int, but argument 2 has type int [-Werror=format=]",
> > > 
> > > So,
> > > 
> > > diff --git a/arch/x86/kvm/svm/sev.c b/arch/x86/kvm/svm/sev.c
> > > index 75d0c03d69bc..ca09c06d1e80 100644
> > > --- a/arch/x86/kvm/svm/sev.c
> > > +++ b/arch/x86/kvm/svm/sev.c
> > > @@ -2951,7 +2951,7 @@ void sev_vm_init(struct kvm *kvm)
> > >                 to_kvm_sev_info(kvm)->need_init = true;
> > >                 break;
> > >         default:
> > > -               WARN_ONCE(1, "Unsupported VM type %lu", kvm->arch.vm_type);
> > > +               WARN_ONCE(1, "Unsupported VM type %u", kvm->arch.vm_type);
> > >                 break;
> > >         }
> > >  }
> > 
> > I'll squash the above.
> > 
> > How did you find this?  E.g. did you cherry pick the commits into a different
> I just pulled the tag kvm-x86-next-2026.04.04, and compiled it with
> "CONFIG_KVM_WERROR=y && CONFIG_BUG=n".

Huh.  TIL it's possible to compile out WARN() and BUG().

Thanks!
