Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DA6A409604;
	Wed,  8 Jul 2026 09:28:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783502894; cv=none; b=FYJDi3TsmEqem1qb8AT1Y/M/xlE54zb3P7vN8i7eUqiYo3iL13rYuZMllk6U6kmbuBHWsdTxnHqnCLC8rQycvkr9HejLvf/rcShIGxHRMeI+XDbCjIG2QpKxSRVPL6f+Eiyshji7tf058f8TXvm4VVOpHQdoPGLO+i1jT7c7+fA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783502894; c=relaxed/simple;
	bh=tqvjmRJbI/JzV/v6cZw7KdN7j6ErUIpr/Rnkc3V+q/M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rlOzb2pdSpQEaTOaU1P/KelfRW3pJsbDGCpbCAl4qexfiLNep/1xlqLyoP4zvPZu12RsuSabPe/HgBwlNdMzuNJwqQWH8DP0WKjNd28X0w87CED7ceT1SZWCSCprkSzl4wcKZ2gQvDrUSFMkyKxkZUEdYRP7KGHXqAKuc98KL0Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IQcduAjU; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IQcduAjU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F98F1F000E9;
	Wed,  8 Jul 2026 09:28:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783502893;
	bh=cPw4yg3tkC/hoD3e06LjjQ5Zm3IV4YnNB2/Ai568sAo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=IQcduAjUSRsmUTbQOHTjmNOExYpI/Q5q/9yQqJUYngzCwCg/Tni0HarhE0Of8iED6
	 gJfSmZunMrz57MO4twctGfIbIyaAD119rNAKRJTZidfbkgZo0tXhATJKH6C3ho/aIl
	 EKwxW4L8N+jfxzTiEaEWm2SHCzfXFdqsRNb3XmWfToEG2Rsu5Kg3BLSNiZu7m0JNT8
	 MWHdmN4GXnO3siYreNQsiyQ0iaVTmRl4+9PS87irWtMfKCyQieX5FcLVvCXPSpJxrk
	 JbxhLYdNZ34etMIypUa9HfD3rz827zkNY8/tdZpOvam8llrrbr367cbojcDIVGQdlQ
	 0SzUm1wwkz5Mg==
Date: Wed, 8 Jul 2026 14:50:18 +0530
From: Naveen N Rao <naveen@kernel.org>
To: Sean Christopherson <seanjc@google.com>, 
	Borislav Petkov <bp@alien8.de>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Paolo Bonzini <pbonzini@redhat.com>, Nikunj A Dadhania <nikunj@amd.com>, 
	Tom Lendacky <thomas.lendacky@amd.com>, Tianyu Lan <tiala@microsoft.com>, 
	Dave Hansen <dave.hansen@linux.intel.com>, Thomas Gleixner <tglx@kernel.org>, 
	Neeraj Upadhyay <neeraj.upadhyay@kernel.org>
Subject: Re: [RFC PATCH v3 00/27] KVM: SVM: Add support for SEV-SNP Secure
 AVIC
Message-ID: <ak4UE13PM-sRfChH@blrnaveerao1>
References: <cover.1783490022.git.naveen@kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1783490022.git.naveen@kernel.org>

On Wed, Jul 08, 2026 at 12:01:58PM +0530, Naveen N Rao (AMD) wrote:
> This is RFC v3 of the patches adding KVM support for Secure AVIC. RFC v2:
> http://lore.kernel.org/r/20250923050317.205482-1-Neeraj.Upadhyay@amd.com
> 
> There are significant changes throughout the series since the last RFC, 
> with some of the highlights being:
> - Integrate with AVIC code since Secure AVIC is APICv, but for protected 
>   APIC guests. This aligns with TDX which also requires APICv and 
>   enables reuse of APICv code paths in KVM. Patches #8 to #14.
> - Mandate use of split irqchip, and drop changes related to the KVM 
>   IOAPIC. KVM PIC/PIT can't be supported (described more fully in the 
>   commit log of the relevant patches). Patch #24.
> - Enable use of SVM_AVIC_INCOMPLETE_IPI VMGEXIT for vCPU notification 
>   request from the guest. Patch #22.
> - Utilize vNMI injection path for NMI handling. Patch #23.
> - Introduce a new kvm_x86_op to distinguish need for injectable 
>   interrupts vs. IPI notifications. Patches #18 and #19.
> - Retain KVM PV ops, and instead require guests to opt-in/disable.  
>   Patch #3.
> 
> Patches #1 to #4 are changes to the guest x2APIC Secure AVIC driver.

I missed mentioning one of the main TODOs on which I am looking for 
suggestions on: handling SVM_VMGEXIT_SAVIC_REGISTER_GPA and ensuring 
that Secure AVIC backing page accesses by the guest do not cause #NPF.  
Patch #16 has the details.

And it looks like I also goofed up Neeraj's email address - sorry! (Now 
fixed)



- Naveen

