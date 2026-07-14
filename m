Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0150E2EEE84;
	Tue, 14 Jul 2026 09:51:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784022690; cv=none; b=KDqutfT3bnigx/cRfeXdlzo+41F7jAqERBmj9vS13d6gYGz/JhxnU9dhHsp6MC2heWZq1ZtUiOwE8Z5fxM7qET7btCHNgQw/ltdKiylEfoSkrd4F6ly3M2LAMyWQL0KP8Zes85jM4rwq7U3ISHQtSB/Qwppyt+pP9yxwp/DE7iU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784022690; c=relaxed/simple;
	bh=J4TMOC66K5+JqjOtbnQ7gUjYg0/uDotEG6Qn6kkuUJ4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jOx/eqWNxQA0Bx9cyUBmSJmScFMtqh+E/1ON9JXfHzWg05mY5Yy1i3MT5qzM96qgc1V797xB/xcLBMjSHKL/5ckOTNI8UW3boyWbCgsunoTi1ySbwHj/PjE29IUVYUnnxnGFsBeEAntixFhzFH83gj64X2wriOtP3LAOYoerPpc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aqqMiUG1; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aqqMiUG1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 42BBB1F000E9;
	Tue, 14 Jul 2026 09:51:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784022687;
	bh=KWMicP+i83Gs/wLv38piRZGYlY2WyZTpjcX4sGhSyS4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=aqqMiUG1RpUG8qED78K0BXnp3HpmkEAJrwiDyNMKN3mxtW9cQTXHBE9PHhFyI5H+j
	 a9KympVadrsYb64ArxwEpsRuymXdYX2Pv/qfUNZey/5yPKg7jWZ1aUNa8QgEgV+GmG
	 VoruFv3BMWKYUAxVHmDroCoM2DXxJL/2VDkYhacIJuSUk1+5/1k0wpZAWkSSZX3U2r
	 c9+lBj6HBuvZbDvfvhS6FTRYei5nUI7EfjNrNbe2IoxWfZo3u2Ow5ysWQOypNJeOD5
	 nskTmsDlG67kNfwgEthfRxgULeYnGY5wisIKOQdKYZo8dGw7T/SmESg4QpN8LKA4I1
	 MtvoUYNJ/1IbQ==
Date: Tue, 14 Jul 2026 15:12:57 +0530
From: Naveen N Rao <naveen@kernel.org>
To: Tom Lendacky <thomas.lendacky@amd.com>
Cc: Sean Christopherson <seanjc@google.com>, 
	Borislav Petkov <bp@alien8.de>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Paolo Bonzini <pbonzini@redhat.com>, Nikunj A Dadhania <nikunj@amd.com>, 
	Neeraj Upadhyay <neeraj.upadhyay@amd.com>, Tianyu Lan <tiala@microsoft.com>, 
	Dave Hansen <dave.hansen@linux.intel.com>, Thomas Gleixner <tglx@kernel.org>
Subject: Re: [RFC PATCH v3 03/27] x86/kvm: Disable PV_SEND_IPI if Secure AVIC
 is enabled
Message-ID: <alX7QbNjf7FkXVRR@blrnaveerao1>
References: <cover.1783490022.git.naveen@kernel.org>
 <730334f9cc320ca738402183c8b8555242a84ba3.1783490022.git.naveen@kernel.org>
 <c2712047-cf0d-43de-be42-fa7ae80277a4@amd.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c2712047-cf0d-43de-be42-fa7ae80277a4@amd.com>

On Mon, Jul 13, 2026 at 12:52:06PM -0500, Tom Lendacky wrote:
> On 7/8/26 01:32, Naveen N Rao (AMD) wrote:
> > In Secure AVIC mode, Linux does not allow IPIs to be injected as the
> > hypervisor is untrusted. This is achieved by not setting the IPI vector
> > in SAVIC_ALLOWED_IRR in the Secure AVIC guest APIC Backing page. Due to
> > this, PV_SEND_IPI cannot work since it needs KVM to be able to inject
> > IPIs into the guest. Disable the same.
> 
> Another guest patch...
> 
> Does this have an impact on the hypervisor? Is the injected IPI just
> ignored because of the SAVIC_ALLOWED_IRR? How would the hypervisor know
> that it needs to schedule the target vCPU if not using this, a write to
> the ICR?

No impact on the hypervisor. Previous KVM implementation relied on 
disabling these at the hypervisor level, which is ok too. But, this 
really should be a guest policy since PV_SEND_IPI can work if the guest 
chooses to allow IPIs (via SAVIC_ALLOWED_IRR).

In the absence of this, guest will use the regular IPI path and go 
through the savic driver, which will do a SVM_EXIT_MSR VMGEXIT to 
request hypervisor assistance for IPI delivery.


- Naveen

