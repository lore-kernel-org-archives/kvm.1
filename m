Received: from mail.8bytes.org (mail.8bytes.org [85.214.250.239])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BAB41FF5E3;
	Tue, 23 Jun 2026 14:44:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.250.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782225856; cv=none; b=kqsTX5AkrVmGxjdTCuI2vB/kp1ntS+FYCy5Wzo3PESiKvQceGyxAFx/T24ECSKksQO0pA+YeHmvep8szbvmhOsMupP5kL+cwEEzEyTeALD+jQmXtknNg7GD+e0Y0AOb3j0B27Z4EEiEUEb1SAq8qCG7oOI1JXY4EtsT873Aampo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782225856; c=relaxed/simple;
	bh=VF0B1j7Yh3faTPhU3DwFyMw95v2glggxg8eF6NI5+FM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uZv2Ad5eU3jZOurekENY1cd7xAkcE7BDSU2HXEz4E+Fr4xqC/6ACmHzIwphhxPxwy5LrXNgSuQyc8hTgn0oa/AL1DQyB+u2AZjbbwvSuOs0kj73CeTKqzha+ooFtmMB2Fo0HAei8WBjAEDhg5AaG3Y/8yqG0S/k7CrSSg5Q7S/I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org; spf=pass smtp.mailfrom=8bytes.org; arc=none smtp.client-ip=85.214.250.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=8bytes.org
Received: from 8bytes.org (p200300f6af4fc50028cc18662c82358e.dip0.t-ipconnect.de [IPv6:2003:f6:af4f:c500:28cc:1866:2c82:358e])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.8bytes.org (Postfix) with ESMTPSA id 10A66203FC4;
	Tue, 23 Jun 2026 16:44:14 +0200 (CEST)
Date: Tue, 23 Jun 2026 16:44:12 +0200
From: =?utf-8?B?SsO2cmcgUsO2ZGVs?= <joro@8bytes.org>
To: Sean Christopherson <seanjc@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, x86@kernel.org, 
	Tom Lendacky <thomas.lendacky@amd.com>, Michael Roth <michael.roth@amd.com>, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, coconut-svsm@lists.linux.dev, 
	Joerg Roedel <joerg.roedel@amd.com>, Jethro Beekman <jethro@fortanix.com>
Subject: Re: [PATCH 4/4] kvm: svm: Support KVM_SEV_SNP_PAGE_TYPE_VMSA at
 SNP_LAUNCH_UPDATE
Message-ID: <ajqVuPlq3XEIGAb2@8bytes.org>
References: <20260611123528.572255-5-joro@8bytes.org>
 <aiqtWVMqTK6vDoZ8@google.com>
 <aiqwjn2DVOumfr3T@8bytes.org>
 <ajGOELiYwKByXbVP@google.com>
 <ajJAYZAPxNrrsiYp@8bytes.org>
 <ajKadxZEMI253AoT@google.com>
 <ajKe-oboTRowcO_i@8bytes.org>
 <ajKjMIBb21qB46fh@google.com>
 <ajKnKeo1FV3zbjEt@8bytes.org>
 <ajqMvQLMGONiLn1S@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ajqMvQLMGONiLn1S@google.com>

On Tue, Jun 23, 2026 at 06:40:13AM -0700, Sean Christopherson wrote:
> On Wed, Jun 17, 2026, Jörg Rödel wrote:
> > The strongest argument in my view (and the main reason we are doing this) is
> > actually the predictable launch measurement. On SEV-SNP this is a requirement
> > to use platform VM-identity features like the ID Block.
> 
> And I'm saying that unless KVM *can't* provide a predictable launch measurement,
> which AIUI isn't the case,

The situation today is that the launch measurement can be predicted with a lot
of internal KVM knowledge (Knowing that KVM creates a VMSA at a fixed GPA at
launch time, how KVM sets it up, ...) and detailed knowledge of the VM instance
(number of VCPUs).

What KVM can NOT do today is to launch an SNP VM with a launch measurement as
predicted by the IGVM format.

And this is what concerns me because the industry is moving towards IGVM for
predicting launch measurments of CoCo VMs.  It is supported in QEMU, in Cloud
Hypervisor, FUKI will use it, SVSM relies on it, and there are certainly more
users I am not aware of.

> then the launch measurement *must* be stable across kernels because it's part
> of KVM's ABI.

The current behavior stays in place and is kept as the default, no ABI
breakage.

> So as I see it, the issue isn't that KVM is inherently unpredictable, it's
> that we lack tests to validate a thorny, subtle piece of KVM's ABI.

I agree that KVM does not cause inherently unpredictable measurements, but a
lot of internal KVM and VM knowledge is needed to predict it. This is a problem
IGVM is meant to solve in a platform- and hypervisor-independent way.

Do you agree that supporting the IGVM use-case is valuable? If so, what would
be your suggestion to make it work on KVM?


-Joerg
