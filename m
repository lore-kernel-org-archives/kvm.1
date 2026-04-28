Received: from mail.8bytes.org (mail.8bytes.org [85.214.250.239])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FFCB3B9D80;
	Tue, 28 Apr 2026 10:52:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.250.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777373572; cv=none; b=uiTSyIHebMmUYdUX1JPkPtisnN5C/0EuyvOq4ry1wFi9PWx3OlMXZBy8Sn9Pu0M5avOSqdGr4ah6w6JFFntxVcqD7sL39ScDK7wUjMz+13hWbto7adFwg6xevQtsuEJ1yPjWfVahWHQAGFArjPspRNlOF75fwXaj5ddyAIuMU6E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777373572; c=relaxed/simple;
	bh=6LfQFUqIq2UfT/ymxTqMHXXBhqgYwmoHty8ORTufbmk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TwQ5wORTOrz1W1nQ0kEFk7Tq5QL33Aquo8k4ZI2BtwSSIN0eWm+kTd13tuppq5jxNW1ZpJzueyC2BuXS6OuNNkEzdXgarWgQYcAc7c2WvNRHp3wHDGF7960n55sGEtgyW6g2tDBunXxZgvTgABStHQJXdzd2pOtiH140CzeCW8M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org; spf=pass smtp.mailfrom=8bytes.org; dkim=pass (2048-bit key) header.d=8bytes.org header.i=@8bytes.org header.b=Kg9AgpJb; arc=none smtp.client-ip=85.214.250.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=8bytes.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=8bytes.org header.i=@8bytes.org header.b="Kg9AgpJb"
Received: from 8bytes.org (p4ffe051a.dip0.t-ipconnect.de [79.254.5.26])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.8bytes.org (Postfix) with ESMTPSA id 387F5200936;
	Tue, 28 Apr 2026 12:52:49 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=8bytes.org;
	s=default; t=1777373569;
	bh=6LfQFUqIq2UfT/ymxTqMHXXBhqgYwmoHty8ORTufbmk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Kg9AgpJbvdqrhUMCYGVoshWH66Z4JwYxyF3D3DKfyudpm8sa05OsZs1mf3QCxGANq
	 y0LVVuXeDJBUYPhW3CTZadzrrMv4tU/2wwk+likmJXSQ8pKlz5AkIUo7aoWUelvxA+
	 rQaBXd/pJoonAMSXOdAq4Bnic+vRwidl8BxyhzOh4z8jV1xtcKM9J0+KcaXh2SCnqu
	 Tf80/IHBpU/qnlhA8wNOUWYeyS7smI/5rCDShnBdrNhw73u+17H3/ufh/RSCBLGSun
	 6LetJ+3rYklWu8Z+ouXEFSK0M41BPLJniDkqIjQ0YZ+MWlcK5wSoz4oaoPbaBDxm/4
	 QNBp+okGfX5BA==
Date: Tue, 28 Apr 2026 12:52:48 +0200
From: Joerg Rodel <joro@8bytes.org>
To: Melody Wang <huibo.wang@amd.com>
Cc: Sean Christopherson <seanjc@google.com>, 
	Paolo Bonzini <pbonzini@redhat.com>, linux-kernel@vger.kernel.org, x86@kernel.org, 
	Tom Lendacky <thomas.lendacky@amd.com>, kvm@vger.kernel.org
Subject: Re: [PATCH v4 7/7] KVM: SVM: Enable Restricted Injection for an
 SEV-SNP guest
Message-ID: <6fqi2slwzxy4bwie6lqtcirdlstnh37epdl4sizfmldk4rnr66@x7s4vjhqxayp>
References: <cover.1777048608.git.huibo.wang@amd.com>
 <20260424175105.4106-1-huibo.wang@amd.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260424175105.4106-1-huibo.wang@amd.com>

On Fri, Apr 24, 2026 at 05:51:05PM +0000, Melody Wang wrote:
> +/* enable/disable SEV-SNP Restricted Injection support */
> +static bool sev_snp_restricted_injection_enabled = true;
> +module_param_named(restricted_injection, sev_snp_restricted_injection_enabled, bool, 0444);

Any particular reason for a module parameter? I think it is fine to just offer
the feature when supported by the hardware and enable it when the VMM (or the
guest, when planes land) requests it.

-Joerg
