Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9126E380FD9;
	Mon, 18 May 2026 18:22:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779128556; cv=none; b=T+e5l+834iUyJW4cn+FNFN9HSuIg4IIeMiwWD5L+FuTbWQKj0M9eRkJ7Z0jlbCE403XUFhHRWtwbPyE9Qt/HH3psxo1mhY0hhGB84pRJH2TVQ78K34RzRXV3F4I8PjSTmqqZznAErq9xCDadnmzoolfSJ+BgpSA9Wze6HDRz+S0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779128556; c=relaxed/simple;
	bh=1TZDR6EqlOQ3KnCkod1HR2OrpF483fUkoOLYk8y/eQQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pfMcU2zn7vVi32hg5QkCsxSETMCwciCGVMkK+iyqK1pdVKKtPdh8r5VRza3XkxHidNggriv87HFs9mOz/JjX7bjifejm4A6UONOpTJAAo3NqXiTXMF3rVf94SAznx+bwvR2+wnrXGCu4f8d+LVFYbpEBEfS7WwkiuJ8GBFPjah8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=I0JkVpTQ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="I0JkVpTQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F012DC2BCB7;
	Mon, 18 May 2026 18:22:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1779128556;
	bh=1TZDR6EqlOQ3KnCkod1HR2OrpF483fUkoOLYk8y/eQQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=I0JkVpTQlO1spfED54rxo8XDGGdHgSLBYxjlZ74DayCRfs3gMQ+EVKFj8RUi3MJOI
	 2VA/FNwldIbhmgK17rVAyH6rbXJ6iiVj+7082CsSSAqmjUyP8bXxEra2SUzJAnMaDx
	 sAL/LHU4Bq9q8z+cW4lrJHSfIyP02xXac/vuiWfP+sIekpBwsP3dxChQ8WvVtehsY/
	 8nmRbCbQ1FuHxpFNgbA6uNWoSjo+yiQ0hkyVLVScGPhTQiqHgvbuA1hEfVDjARTFbT
	 1LO3rlLWlGcC4IYK7uZ9QrXCrLcr0+keiqzCJ59t7NfJWIArLgyN/YsKoWbJIwqBaT
	 4KcLvJXFvZPHw==
Date: Mon, 18 May 2026 18:22:34 +0000
From: Yosry Ahmed <yosry@kernel.org>
To: Sean Christopherson <seanjc@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Hou Wenlong <houwenlong.hwl@antgroup.com>, 
	Lai Jiangshan <jiangshan.ljs@antgroup.com>
Subject: Re: [PATCH v3 07/10] KVM: x86: Drop kvm_vcpu_do_singlestep() now
 that it's been gutted
Message-ID: <agtY48QF4JxPQIje@google.com>
References: <20260515222638.1949982-1-seanjc@google.com>
 <20260515222638.1949982-8-seanjc@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260515222638.1949982-8-seanjc@google.com>

On Fri, May 15, 2026 at 03:26:35PM -0700, Sean Christopherson wrote:
> Now that all of kvm_vcpu_do_singlestep()'s previously-unique functionality
> has been moved into kvm_inject_emulated_db(), drop the one-line wrapper.
> 
> No functional change intended.
> 
> Signed-off-by: Sean Christopherson <seanjc@google.com>

Reviewed-by: Yosry Ahmed <yosry@kernel.org>
