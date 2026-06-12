Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E72538D3EC
	for <kvm@vger.kernel.org>; Fri, 12 Jun 2026 21:26:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781299616; cv=none; b=ZsF/0vxkWIjwLrYWBf86PUmc5GMyEI2yVCaznvXCz0XcPgEFUI8s/iPkbgM1uw0Mo1Z/IgLFBfUVQnCioUQcKLfUOmURJwzJ/Iidy+KJrKLW+tlQKIwPSEAXcl+UWsm2xeIvkjN3ul3h8jIbnqjTOYUzitG94oSyD58Bu2UdQWM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781299616; c=relaxed/simple;
	bh=9+xEN1tkIIGm2RXMoQgvBBkgp/sLH10Ki/bUiUu+M6Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZA6G1cYbdA45MvRZzGPyLDautsTHG4bHcIlrW8v90zvXBOEGhPO+WqKqstDqQF1y4yDO+CVLrE3sldsYR/kCxV0Dmgk9LIGNmg3QmIlwmZbQQu+EeT1i32R7RXVI26exVjEokHvNxlr1ENLqNUv5a4c7au6aP/VJUqNjDBk5Tbk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=J9PMCZdW; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="J9PMCZdW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DCEBC1F000E9
	for <kvm@vger.kernel.org>; Fri, 12 Jun 2026 21:26:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781299614;
	bh=ioqGnK50uujx2lPpJanGqgidUKK04Gwcux3S6H17ENU=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=J9PMCZdWYnIWC4waf4KiXCNHAiqh0dWXewPEHb86hqlTi5DxaYl2ZdZfGEaeyH/oX
	 bBqBXMstUwYXRgAQk//qIFVEJbSzd23kbij8B1OmnlDvSlLlOqZbVc+Ha1qSO2Spmx
	 ULgkrpzimITX2/CFO5WqDvoNicl20WRvexT1bqA+0QzyZtYeH/oA1KyVZeY0nsJlPB
	 3gL7pQj9cPqA0XM5KSgaQ0Yrb81vUy74C66nCoR51cf42BoRSluAkyneJzsetxCKrD
	 AsEaysav39YxiXUXMohIIZvuvzKzVP8kTBUuaAIyttI3IBrWAdWBT4P9lEinajjTDS
	 oNVWDz4uF58pg==
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-bebbc325000so204970266b.0
        for <kvm@vger.kernel.org>; Fri, 12 Jun 2026 14:26:54 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ9nwgOi/thE0gUSodsM4jUGv0KeKKmX75+ASVU1jjRwXxJ8J8LhRpTtisKUknYHLZfxj5E=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy4a/3cyacs5Gstvfi9HqP7L9UZRhrtOTVOAMYxgfNlDrRf48f9
	6iVDIlekqOkPHe6+fZ6djJ5T5NXfMBDlBWFmmx8KcENVdCeRJoZ+XQASYjTii9+hIwReqoJF4bl
	ycI/2h3Jp5LD1NcRCPRK1WQgkLw1O9j8=
X-Received: by 2002:a17:906:c150:b0:bef:36f3:7277 with SMTP id
 a640c23a62f3a-bff4a30f4efmr61297466b.23.1781299613910; Fri, 12 Jun 2026
 14:26:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260612185459.591892-1-seanjc@google.com>
In-Reply-To: <20260612185459.591892-1-seanjc@google.com>
From: Yosry Ahmed <yosry@kernel.org>
Date: Fri, 12 Jun 2026 14:26:41 -0700
X-Gmail-Original-Message-ID: <CAO9r8zPqN7x727_AWmbcYc_++t3+0JJyDLgzudPRXbm_rOx5yA@mail.gmail.com>
X-Gm-Features: AVVi8Cf5VguZOqv7yJj9CSDxOYiBFdco50-jfHVXlFqVvIndTT2DC7KxkVAp8Ho
Message-ID: <CAO9r8zPqN7x727_AWmbcYc_++t3+0JJyDLgzudPRXbm_rOx5yA@mail.gmail.com>
Subject: Re: [PATCH] x86/apic: KVM: Use cpu_physical_id() to get APIC ID of
 running vCPU for AVIC
To: Sean Christopherson <seanjc@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, 
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Kai Huang <kai.huang@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 12, 2026 at 11:55=E2=80=AFAM Sean Christopherson <seanjc@google=
.com> wrote:
>
> Use cpu_physical_id() instead of default_cpu_present_to_apicid() when
> getting the APIC ID of the pCPU on which a vCPU is running/loaded, as the
> kernel has gone way off the rails if a vCPU is loaded on a pCPU that has
> been physically removed from the system.  Even if the impossible were to
> happen, the absolutely worst case scenario is that hardware will ring the
> AIVC doorbell on the wrong pCPU, i.e. a severely broken system will
> experience mild performance issues.
>
> Kill off KVM's superfluous kvm_cpu_get_apicid() wrapper along with the
> for-KVM export of default_cpu_present_to_apicid(), as they existed purely
> for the wonky AVIC usage.
>
> Cc: Kai Huang <kai.huang@intel.com>
> Cc: Yosry Ahmed <yosry@kernel.org>
> Signed-off-by: Sean Christopherson <seanjc@google.com>

Took me a bit to realize cpu_physical_id() is the APIC ID, but yeah
this looks to be equivalent as long as the CPU is present, which as
you described should be true as long as we didn't screw up.
cpu_physical_id() seems to also be used by VMX anyway.

Reviewed-by: Yosry Ahmed <yosry@kernel.org>
