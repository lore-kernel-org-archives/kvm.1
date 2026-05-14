Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E17C25B0B7
	for <kvm@vger.kernel.org>; Thu, 14 May 2026 15:18:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778771932; cv=none; b=Uzl479lLDpMyn1wPbdOESqx2hu/SFs0HOrKpE8zofVI+QdaeXcbAPEErc/jJLR6uYZGTT7Zqki6j5BljMLmL7bCpFqaQAA8UUvCtviH7nOwQtWI4TKfsfuk46tsXWW4nIr1+ACT5YGrmH75oa9wRX4OwwduupojmjUpg9iGQk4M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778771932; c=relaxed/simple;
	bh=RAd6xH/eZfyw+a2Hd/pf+JfPw/IFE8nnA42jxMXKp4E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DEoZzErtR9fHVLil8WDI/oZLJhasQd21nTaM244sttAhiU0I0SDknmx80N15kNjW78JoYmdDfLwf9N+Lo+GkVSi2WyDmbDyzmOnjUIwpz5tA1rHURa1xKx/HQ6SaoIhbglLxjYMFsU9/FHElwyqUbfSfYnN4Sil9uAwgdK/hCxw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DlaBQsKe; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DlaBQsKe"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 69731C2BCB3;
	Thu, 14 May 2026 15:18:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778771932;
	bh=RAd6xH/eZfyw+a2Hd/pf+JfPw/IFE8nnA42jxMXKp4E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=DlaBQsKey6KuE4gTY5eQqu++bUC4XSjE5yUYqab4W2ecwCByY1bHZcnOldjNI9t3j
	 ZQkB2QlVEwfDXL2bqFzQmQqUiaz5p42liLWUV1xESOwumvSXZklqBxdXAaqAsEx2jl
	 rUSfP+no7jQOs0QolY//LGYfdkWJwXfvG5NEkQj9NVPgf3J+LxV9ovdA6K1NKpUzqB
	 WI54DQ0zDPI8SC/eAWV1dCKqE6DYWTvyFuVtwtCeh6RMAWRssVzadrFXqptTGK2Hp5
	 EFdu/k/CDW/Tq09ynqbne09hjkj9PwtMnigsNdrrH6lgbQ+2UamS1k946CTmb72e20
	 Pp90jDwy/onaA==
Date: Thu, 14 May 2026 20:40:22 +0530
From: Naveen N Rao <naveen@kernel.org>
To: Manali Shukla <manali.shukla@amd.com>
Cc: seanjc@google.com, pbonzini@redhat.com, mingo@redhat.com, bp@alien8.de, 
	dave.hansen@linux.intel.com, kvm@vger.kernel.org, x86@kernel.org, santosh.shukla@amd.com, 
	nikunj.dadhania@amd.com, dapeng1.mi@linux.intel.com
Subject: Re: [PATCH v1 9/9] KVM: SVM: Add AVIC support for extended LVT MSRs
Message-ID: <agXiCnwgYHHLZwXS@blrnaveerao1>
References: <20260204074452.55453-1-manali.shukla@amd.com>
 <20260204074452.55453-10-manali.shukla@amd.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260204074452.55453-10-manali.shukla@amd.com>

On Wed, Feb 04, 2026 at 07:44:52AM +0000, Manali Shukla wrote:
> Configure MSR intercepts for extended LVT registers when both AVIC and
> AVIC_EXTLVT are supported by hardware.  Extended LVT registers are
> x2APIC MSRs at offsets 0x500-0x530 in the APIC register space.

That sounds a bit weird, since AFAIK the extended LVT registers are also 
present in the MMIO-based xAPIC.

> 
> When AVIC is enabled and MSR intercepts are disabled, allow passthrough
> access to extended LVT MSRs.  Hardware accelerates reads without VM-exits,
> while writes trigger trap-style VM-exits that are handled by the existing
> avic_unaccelerated_access_interception() path.

With Sean's recent changes 
(https://lore.kernel.org/kvm/20260506184746.2719880-1-seanjc@google.com), 
the preference is to intercept all the MSRs that are not 
write-accelerated by AVIC, so the only change for this patch would be 
for AVIC_UNACCELERATED_ACCESS handling for xAVIC.

Also, per the APM Section "15.29.3.1 Virtual APIC Register Accesses":
	"Accesses to any other register locations not explicitly defined 
	in this table are allowed to read and write the backing page."

So, I don't think we need to be too strict about which EILVT registers 
can cause this. It's probably simplest to just list the 4 EILVT 
registers handled by AVIC today:

diff --git a/arch/x86/kvm/svm/avic.c b/arch/x86/kvm/svm/avic.c
index 101ffab48145..b2eececf41e9 100644
--- a/arch/x86/kvm/svm/avic.c
+++ b/arch/x86/kvm/svm/avic.c
@@ -818,6 +818,13 @@ static bool is_avic_unaccelerated_access_trap(u32 offset)
        case APIC_TDCR:
                ret = true;
                break;
+       case APIC_EILVTn(0):
+       case APIC_EILVTn(1):
+       case APIC_EILVTn(2):
+       case APIC_EILVTn(3):
+               if (cpu_feature_enabled(X86_FEATURE_AVIC_EXTLVT))
+                       ret = true;
+               break;
        default:
                break;
        }


- Naveen

