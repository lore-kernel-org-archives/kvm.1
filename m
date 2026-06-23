Received: from mail.8bytes.org (mail.8bytes.org [85.214.250.239])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E335E3D0BE7;
	Tue, 23 Jun 2026 10:55:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.250.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782212118; cv=none; b=F4Gp4pJYD9Mrns3PRZR7g4bx536Q3URn/yKgY0HS1nk/egenlIz3TTdAlHferbUfPbPPzPGZ8ADAE84/gEplUPbR7sk4zPCz43lL31GQjjc4MA1YWOSY8liDqtPHLC2RksSGSdzu+VJl3TdA4aNFgO1FscGW6Z6zvhPnNaX7Tlg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782212118; c=relaxed/simple;
	bh=h/9xuOQaDFu9FJOSwW8NmHrA26zYcltPOrdP6rzQ2aE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sTmXtXTK8o+CKRVYzdfrh34E9YEM35mwnUKtyIqmgjEIc3P4aUTLA1F8roFnytR5r6qY46PKbFSUtnHJcxdeh8smT4wJvBiFJmoDwoQ8WDU9ac+giV3HGjVC9vDxbkA/vf750Wl7Pz6ufEFu0T1Yas5J24l883iogopczygixxQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org; spf=pass smtp.mailfrom=8bytes.org; arc=none smtp.client-ip=85.214.250.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=8bytes.org
Received: from 8bytes.org (p200300f6af4fc500afaede31c5136906.dip0.t-ipconnect.de [IPv6:2003:f6:af4f:c500:afae:de31:c513:6906])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.8bytes.org (Postfix) with ESMTPSA id 82C49203DA5;
	Tue, 23 Jun 2026 12:55:15 +0200 (CEST)
Date: Tue, 23 Jun 2026 12:55:14 +0200
From: =?utf-8?B?SsO2cmcgUsO2ZGVs?= <joro@8bytes.org>
To: Tom Lendacky <thomas.lendacky@amd.com>
Cc: Sean Christopherson <seanjc@google.com>, 
	Paolo Bonzini <pbonzini@redhat.com>, x86@kernel.org, Michael Roth <michael.roth@amd.com>, 
	kvm@vger.kernel.org, linux-kernel@vger.kernel.org, coconut-svsm@lists.linux.dev, 
	Joerg Roedel <joerg.roedel@amd.com>
Subject: Re: [PATCH 1/4] kvm: svm: Streamline VMSA setting for VCPUs
Message-ID: <ajpl0uR1bBxtbtXo@8bytes.org>
References: <20260611123528.572255-1-joro@8bytes.org>
 <20260611123528.572255-2-joro@8bytes.org>
 <5dc215d1-ea45-4e4d-b79f-0490c1940639@amd.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <5dc215d1-ea45-4e4d-b79f-0490c1940639@amd.com>

Hi Tom,

On Tue, Jun 16, 2026 at 03:52:55PM -0500, Tom Lendacky wrote:
> On 6/11/26 07:35, Jörg Rödel wrote:
> >  static int snp_decommission_context(struct kvm *kvm);
> > +static int kvm_rmp_make_shared(struct kvm *kvm, u64 pfn, enum pg_level level);
> > +static void sev_flush_encrypted_page(struct kvm_vcpu *vcpu, void *va);
> > +static int snp_page_reclaim(struct kvm *kvm, u64 pfn);
> 
> Can this be worked so that we don't add more forward declarations?

Thanks for the review. I have worked in all your comments into v2.

-Joerg

