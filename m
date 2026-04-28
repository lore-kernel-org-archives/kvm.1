Received: from mail.8bytes.org (mail.8bytes.org [85.214.250.239])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1BAE3F1655;
	Tue, 28 Apr 2026 10:50:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.250.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777373418; cv=none; b=gItwZgJnreLmmg+TU92pfS+csdU1o0pbKttcS3Na4xTdEQUgXdsY75MHsgDNMVlH5lcibGnZsDpEC2P+oYi7Fmr6PhV3Db+AJQ/aHC0xxEIoBwCJOrYemB5MHDfbPIN6FFwIPAlTifnkzvNdYu38eimXSbfSAYbhNQ0n4HOgLzQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777373418; c=relaxed/simple;
	bh=8ZrdSAbD+qM4d6qkrSqQZHYw16yBPEG/+Vdsk0nKTAo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VLndz4j7ivzUaQdcFH5gBzpbhER889fk5XYfZPfjzcZ6+OS7YGW53dtCBABsnbbK0v8xzJZJIImPIZLc81D5iy1Fo/n0sf6pNds9uKZUKqNjtChvx09gryVGfe4f4sLnVDrUiwPbMdVZXq1AqD/MpjQoXZd/KM4afHMb/Bj3Fuw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org; spf=pass smtp.mailfrom=8bytes.org; dkim=pass (2048-bit key) header.d=8bytes.org header.i=@8bytes.org header.b=03YekhSi; arc=none smtp.client-ip=85.214.250.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=8bytes.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=8bytes.org header.i=@8bytes.org header.b="03YekhSi"
Received: from 8bytes.org (p4ffe051a.dip0.t-ipconnect.de [79.254.5.26])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.8bytes.org (Postfix) with ESMTPSA id 250DB200936;
	Tue, 28 Apr 2026 12:50:15 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=8bytes.org;
	s=default; t=1777373415;
	bh=8ZrdSAbD+qM4d6qkrSqQZHYw16yBPEG/+Vdsk0nKTAo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=03YekhSil1SXJAnpSqcWbne6AUJXXFxzN7mENhSLjhzVMeO0jnxjWJk2JmCWmT6K0
	 GQ/MtV/dYn/rfqzWf53CtXUe5+tBkrFewdNgaIZ5I6ujsy1ZgULjdTBzBXdR8ZbHrP
	 JG1rLWYolHdD8J7+xwoJ65bwU4jAPJWKFG66bK1ZqK7qrVu0KJ2lB87JWSgZMx8sZy
	 z/rYyNmxVYD0iNoY+WLfGz9+RSbfvER3PntErCzFuzUFwNXt9ZfsrijAreb1BBTIuk
	 NRvsbnMpiXUafvD0L3DZ4XZV/xbGQkLHMkIWL4wkdsfM15PFYyq0Oq+Wm3JstUGzxb
	 I2TrFZE8N4PTg==
Date: Tue, 28 Apr 2026 12:50:13 +0200
From: Joerg Rodel <joro@8bytes.org>
To: Melody Wang <huibo.wang@amd.com>
Cc: Sean Christopherson <seanjc@google.com>, 
	Paolo Bonzini <pbonzini@redhat.com>, linux-kernel@vger.kernel.org, x86@kernel.org, 
	Tom Lendacky <thomas.lendacky@amd.com>, kvm@vger.kernel.org
Subject: Re: [PATCH v4 5/7] KVM: SVM: Inject MCEs when Restricted Injection
 is active
Message-ID: <u4vvzt56ldo2dfhrdo3nwzw46ktqtngob6ng2qbgypqeyxcbmn@akgecfbqkloy>
References: <cover.1777048608.git.huibo.wang@amd.com>
 <51f8c478c5fc09b3bdeb8329c682a01fbe0ea5db.1777048608.git.huibo.wang@amd.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <51f8c478c5fc09b3bdeb8329c682a01fbe0ea5db.1777048608.git.huibo.wang@amd.com>

On Fri, Apr 24, 2026 at 05:42:09PM +0000, Melody Wang wrote:
> diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
> index 0a1b63c63d1a..420f1ec0dcfb 100644
> --- a/arch/x86/kvm/x86.c
> +++ b/arch/x86/kvm/x86.c
> @@ -10789,6 +10789,12 @@ static int kvm_check_and_inject_events(struct kvm_vcpu *vcpu,
>  			kvm_update_dr7(vcpu);
>  		}
>  
> +		if (vcpu->arch.exception.vector == MC_VECTOR) {
> +			r = static_call(kvm_x86_mce_allowed)(vcpu);
> +			if (!r)
> +				goto out_except;

If this path is taken the warning at the bottom of the function will trigger. I
think the target needs to be out: instead of out_except.

-Joerg
