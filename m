Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2301C30ACE6;
	Mon, 23 Feb 2026 16:40:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771864848; cv=none; b=DkQwt8ge6G8iXSrJG+S4Ak/WKY4YRqaLSX7ZlzGSuW46Z3/P++b3wmd+NNJxB/ST6wps7OlG7zfPfB0PBniFsLSnMwpou/CGuatX7CZB7+Lg82L3/Te3mc/Y+kAutf6gxhuWedyZSe9fZHF008WEGSg6dpjVdyGM8ePXQwibeLw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771864848; c=relaxed/simple;
	bh=DHzusBLHS1PKE5rCYY+8SAh4a8JwXvDMvJdyfDxw7xE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HNPMyDPWMrdakSF1pcIloFJS43gZURBjuSfg2Ao4PWOLLqeu4MpOfV2JqpNw7SdqxCQmJTouS6DF9ktvjI13UL1zzwXukQVCEoPpCEchh4bSfEs0qadO+Da3rEqmv9RpbF8kYTgWAWf6k5pAXPzZntbAaTk2AebMdo1D7lqKvMc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QxwElzQB; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QxwElzQB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DCCC7C116D0;
	Mon, 23 Feb 2026 16:40:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771864847;
	bh=DHzusBLHS1PKE5rCYY+8SAh4a8JwXvDMvJdyfDxw7xE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=QxwElzQBqMD9lQ4CrGHf9wUEEaA8D0KGxvTimJPuTn2YwFcPZL/sIyQupvw5y17ZZ
	 pdwfA+IGdr3CbN0Jdz3Z+FiZxxxK0oRPYP/ONH0J6RXdsSyIM5qfvfFxNXFYHvNUWx
	 fCyBa51y70VozM46WXjL2fZXUniLAUpwFt15nqnqP9xC5QWNvYpI+3kAor8ffARXXY
	 VtD1pWS+j4CdE4Krcbg9OtetjPciJUEaVdRS54+ULrdzid4usIL851Ur31TcL/kZOM
	 OwtDkxXOWmy3pQCWLiStlWXL4ZYc7Gr4CjebaJxWac6BmvLWaudWPG2J5klXaTztMK
	 dcvXcyeRMdZ4A==
Date: Mon, 23 Feb 2026 22:08:03 +0530
From: Naveen N Rao <naveen@kernel.org>
To: Gal Pressman <gal@nvidia.com>
Cc: Sean Christopherson <seanjc@google.com>, 
	Paolo Bonzini <pbonzini@redhat.com>, Thomas Gleixner <tglx@kernel.org>, 
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>, 
	kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Dragos Tatulea <dtatulea@nvidia.com>
Subject: Re: [PATCH 1/2] KVM: SVM: Fix UBSAN warning when reading avic
 parameter
Message-ID: <aZx_VsnmWLx96AeY@blrnaveerao1>
References: <20260210064621.1902269-1-gal@nvidia.com>
 <20260210064621.1902269-2-gal@nvidia.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260210064621.1902269-2-gal@nvidia.com>

On Tue, Feb 10, 2026 at 08:46:20AM +0200, Gal Pressman wrote:
>  
> +static int avic_param_get(char *buffer, const struct kernel_param *kp)
> +{
> +	int val = *(int *)kp->arg;
> +
> +	if (val == AVIC_AUTO_MODE)
> +		return sysfs_emit(buffer, "auto\n");

My preference would be to return 'N' here, so that this continues to 
return a boolean value when read.


- Naveen

