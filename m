Received: from mail.8bytes.org (mail.8bytes.org [85.214.250.239])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA8B252B1DE;
	Wed, 16 Sep 2026 16:31:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.250.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789576288; cv=none; b=R/s/AzqHSQu+KvT6e2EjfxmaIQ5WfQm/S3wtnWGiZR6VnmGvglcC0PN6fpbjV6Cf3QeO3Z5q4Q2kGUKUhMzKJbzluodxfaW9A1NLA9aDT3J0Gq34EPBbSRK1c/O7MpxB08yTZEilRmVkKXj6XlPnobNY1aoa/3vbJz9aXbut8k8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789576288; c=relaxed/simple;
	bh=E0sO8C0FnPRMoOQt5I4SYevkaxSUZHFuyAxd43gzVBU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Lw7bci/sfY83UNdISluTtgAXR+4/XHZP+DRZJHug1wuJuuWyEQkwz6N3LTpSoMnvt8NZHF27BwgE3Qln0T0XBoB5nTg2m+q7WS0TN4ER03+PLrrE/rTS55aUzFQCT87D7ua/6uYETkjg8yer82sJW+mfQJ0H3vyZsPJ2aalHjcU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org; spf=pass smtp.mailfrom=8bytes.org; arc=none smtp.client-ip=85.214.250.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=8bytes.org
Received: from 8bytes.org (p200300f6af404a0026c58e89ee133047.dip0.t-ipconnect.de [IPv6:2003:f6:af40:4a00:26c5:8e89:ee13:3047])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.8bytes.org (Postfix) with ESMTPSA id E5BAF1C1958;
	Wed, 16 Sep 2026 18:31:05 +0200 (CEST)
Date: Wed, 16 Sep 2026 18:31:04 +0200
From: =?utf-8?B?SsO2cmcgUsO2ZGVs?= <joro@8bytes.org>
To: Tony Lindgren <tony.lindgren@linux.intel.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, 
	Sean Christopherson <seanjc@google.com>, Michael Roth <michael.roth@amd.com>, 
	Liam Merwick <liam.merwick@oracle.com>, Vishal Annapurve <vannapurve@google.com>, 
	Ninad Naik <ninadnaik07@gmail.com>, Joerg Roedel <joerg.roedel@amd.com>, 
	Tom Lendacky <thomas.lendacky@amd.com>, James Bottomley <James.Bottomley@hansenpartnership.com>, 
	kvm@vger.kernel.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, coconut-svsm@lists.linux.dev
Subject: Re: [PATCH v2 6/8] KVM: SEV: Add SNP vCPU state get and set commands
Message-ID: <aqrDUgB7nfdgzXpQ@8bytes.org>
References: <20260908103338.427254-1-joro@8bytes.org>
 <20260908103338.427254-7-joro@8bytes.org>
 <aqksXLLcmFDkM9Xj@tlindgre-MOBL1>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aqksXLLcmFDkM9Xj@tlindgre-MOBL1>

Hi Tony,

On Tue, Sep 15, 2026 at 02:30:36PM +0300, Tony Lindgren wrote:
> Nice, looks like snp_get/set_vcpu_state() could quite easily make use
> of KVM_EXPORT/IMPORT_VCPU?

That depends on whether KVM_EXPORT/IMPORT_VCPU will migrate the confidential
VCPU state (registers) only or hypervisor state as well. The get/set_state
helpers here only export/import the hypervisor tracking state for the guest
VCPUs.

On AMD the confidential VCPU state is migrated as part of the memory image when
guest execution has stopped on the source side.

-Joerg

