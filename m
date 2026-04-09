Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED631375F67
	for <kvm@vger.kernel.org>; Thu,  9 Apr 2026 21:17:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775769481; cv=none; b=Pit5MAboalVo/LyStSlsk3v0anT+md/vGDA8zsg9c01ugVCfktyitKFr5M1zo4AB0kITsHqfdP5r9tETYhwsMDgQqr9l0zOPYk8tbjasy4MDdTW8IAV/3wEXLKVYAPdZMFyXupbeU404IWLFQKZpY4IurMyq8DC+SJEcHfy8BRE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775769481; c=relaxed/simple;
	bh=kTGNLbn4hMgKaLX8TjQOM8N2QBw0VnJstnv2OfEAq4o=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=SWic3JVNrJnrHogd++sRmlzbvTjnavsF0ES33hzyR71I4ioww8L2eJO8osmOYGs63aFlrO+9yRfq1+YnGZy9E2gsefl+qcibgN2410quv7LecHJb9LpnwhgNZ3lCPzXai9UqsShuH1Rv+g8kM2uG1ErORVvt78NpCfRbKAhnQfI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=M7QKu54u; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="M7QKu54u"
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-35da86144daso1899696a91.3
        for <kvm@vger.kernel.org>; Thu, 09 Apr 2026 14:17:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1775769478; x=1776374278; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=463dllVAQ+CXXYb1cF+GtnlCvXOZXdOn20lYdKT+eLg=;
        b=M7QKu54uxIYZnsPyUxowHmIoEdSF6/uxRX4ghURj98Kd+M+cdrsLtQqNxGcpaXbhks
         Ehqls/oBTkC8x1Zg6npzwWGe9x9OY1xkn2Cc8ipFTr10SYMj7xKYe21fG6k1/R3okiBs
         F4nDeV0JN2tdCYIrOqSHG7WbH2TTR/XzZ9OWpmMeh4gvyjlc3xSDIjrdgaKQtLvC6sbM
         o66wRVzZHX1IhHLVhdiLqQpHYT1kTmL5CdnHNldew1Ezxc7zjFnbkMDIDtcJeAHIeZgM
         x902TEuuh5bDu00LnlI7RkLPk5Wz8dS64j3R9EpqFgaYuJADpm/WHN8jY9WPBRtyXOQk
         +VJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775769478; x=1776374278;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=463dllVAQ+CXXYb1cF+GtnlCvXOZXdOn20lYdKT+eLg=;
        b=Zaja0A+9rb6gAXfXQW1Ap/RPjrfYynu/r+cI2e3mIK0WMWOuUJqkXFPhUGQeH1voIm
         NVrTQfYzIbEEqEhE9d9bLtBp3JiLnTqX9EYc9vL3r9sRnbr0yDdgrExCgk/QL9oc6NfG
         2AJG6sKgxS8XpkA2bVXqb94YMylGaZ2oRT8nVsGq6xLdwRixihXjBgicwEy8VgH2Nmbc
         Yupx8hJMyfRjgAtYJrctwDZSGcpwDtMxaVHLXbb2UdnnwHoPGeDhFMbccl2SUsOplqEi
         DIla2ihiFqyK3Rpr6HRDHSCdWU9UJ+AMQIWkg2P1pucQy58cV8Er8b/xNYMSQB84Mml8
         89yg==
X-Forwarded-Encrypted: i=1; AJvYcCWx26vlli6c4KQqjbe8I8Ue8kWvfKParqaVN4kPHwEcyXvOY0UYGQ1U2x/zD8gBLnnkFDk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz/+Nnn4DCkCqmtx4u/C15/zPH8X+8o4OgAdytXIJVx2uQHzf9Q
	0zX2iR8x60yCu+JvPFjEyxJqBm6m2lc/MRdKARkQHi2+7A8UojsxmPxEBXFEJjw1IEnpglpumdU
	/3gBtDA==
X-Received: from pjbgi21.prod.google.com ([2002:a17:90b:1115:b0:35d:a45d:bc03])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:2d07:b0:35d:a3b4:2f0d
 with SMTP id 98e67ed59e1d1-35e4274e1damr551175a91.6.1775769478020; Thu, 09
 Apr 2026 14:17:58 -0700 (PDT)
Date: Thu, 9 Apr 2026 14:17:56 -0700
In-Reply-To: <20260324194034.1442133-5-tycho@kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260324194034.1442133-1-tycho@kernel.org> <20260324194034.1442133-5-tycho@kernel.org>
Message-ID: <adgXhPzjpq5aTS5z@google.com>
Subject: Re: [PATCH v2 4/5] KVM: SEV: mask off firmware unsupported vm types
From: Sean Christopherson <seanjc@google.com>
To: Tycho Andersen <tycho@kernel.org>
Cc: Ashish Kalra <ashish.kalra@amd.com>, Tom Lendacky <thomas.lendacky@amd.com>, 
	John Allen <john.allen@amd.com>, Herbert Xu <herbert@gondor.apana.org.au>, 
	"David S. Miller" <davem@davemloft.net>, Paolo Bonzini <pbonzini@redhat.com>, 
	Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>, Shuah Khan <shuah@kernel.org>, linux-crypto@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Kim Phillips <kim.phillips@amd.com>, 
	Alexey Kardashevskiy <aik@amd.com>, Nikunj A Dadhania <nikunj@amd.com>, kvm@vger.kernel.org, 
	linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"

On Tue, Mar 24, 2026, Tycho Andersen wrote:
> From: "Tycho Andersen (AMD)" <tycho@kernel.org>
> 
> In some configurations not all VM types are supported by the firmware.
> Reflect this information in the supported_vm_types that KVM exports.
> 
> Link: https://lore.kernel.org/all/aZyLIWtffvEnmtYh@google.com/
> Suggested-by: Sean Christopherson <seanjc@google.com>
> Signed-off-by: Tycho Andersen (AMD) <tycho@kernel.org>
> ---
>  arch/x86/kvm/svm/sev.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/x86/kvm/svm/sev.c b/arch/x86/kvm/svm/sev.c
> index 37490803f2e8..0fe9515db1e7 100644
> --- a/arch/x86/kvm/svm/sev.c
> +++ b/arch/x86/kvm/svm/sev.c
> @@ -2976,7 +2976,8 @@ void __init sev_set_cpu_caps(void)
>  		supported_vm_types |= BIT(KVM_X86_SNP_VM);
>  	}
>  
> -	kvm_caps.supported_vm_types |= supported_vm_types;
> +	kvm_caps.supported_vm_types |= (supported_vm_types &
> +					sev_firmware_supported_vm_types());

This is slightly flawed, in that sev_hardware_setup() still reports SEV-ES as
fully enabled, whereas the other cases (ASID exhaustation) clear the VM type *and*
report the feature as "unusable".

Addressing that is actually a great opportunity to dedup some code in the previous
path.  I.e. if we first relocate the supported_vm_types updates to sev_hardware_setup(),
then there's no need to copy+paste the ASID checks.  And then restricting VM types
based on firmware support Just Works.

E.g. to yield:

[ 1813.863571] ccp 0000:24:00.1: SEV-SNP API:1.58 build:1
[ 1813.876790] kvm_amd: SEV enabled (ASIDs 254 - 509)
[ 1813.881595] kvm_amd: SEV-ES unusable (ASIDs 1 - 253)
[ 1813.886574] kvm_amd: SEV-SNP enabled (ASIDs 1 - 253)
[ 1813.891549] kvm_amd: Virtual VMLOAD VMSAVE supported
[ 1813.896522] kvm_amd: Virtual GIF supported

I'll send a v3, I've got everything coded up (I wanted to make sure my idea
actually worked before suggesting it :-) ).
