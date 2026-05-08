Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 315672EBDDE;
	Fri,  8 May 2026 17:12:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778260335; cv=none; b=Vwox4LdQasRUQDWyqPdNQsJvGEFN7Wc3dJ83aogzJ/fUlijJgkKRkfK/Ytu0N8ar8pWSWUdGvqWFsVWSQq4cnCKnNzVd4nwo8QQcjRVLdvNUvM9iMmaiZSq0K7MMUPRTag54luGKIY72TPw4JifUrm1LiiEOMJKr9qq2HLbKTTw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778260335; c=relaxed/simple;
	bh=EsTFf7qnfgE+DcO+/SX3IscCKG+dFx0MhM0eybb1Br0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nisdx1pJakQ9SV3zpnY6rBN6QCSqXO05c4sQh/LZVjBU2sqfK9UuO1gI/e0anzePYUOGfH+RHQZDldd+AAixSLhDIyx6x75dPQN44JhQ1QZTXfiFM5PTmh+3c9f5cMblLJAkZMk4y6dAKX3x5M198K+P+AQGPe3qPzgA4Vi1FFY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=lBWwwRz6; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="lBWwwRz6"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 342B8152B;
	Fri,  8 May 2026 10:12:07 -0700 (PDT)
Received: from J2N7QTR9R3 (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id BB5373F836;
	Fri,  8 May 2026 10:12:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1778260332; bh=EsTFf7qnfgE+DcO+/SX3IscCKG+dFx0MhM0eybb1Br0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=lBWwwRz6a7nQ+hxFzW7BK5GC6EHeiTMOdrBs3x9Zf5HTznIGt5K+jW1zVvoJHdbDf
	 GHGt2GY6xACd/0ZcKFbLVIVzwtYMQBc8CCkJF4lqxpcJadMZQzJeBdhVyTKl0C0v8I
	 0fUH7k+0aNuGeZVlRsbF/WzGoxbSJyITngBWIpRk=
Date: Fri, 8 May 2026 18:12:01 +0100
From: Mark Rutland <mark.rutland@arm.com>
To: Mark Brown <broonie@kernel.org>
Cc: Marc Zyngier <maz@kernel.org>, Joey Gouly <joey.gouly@arm.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Will Deacon <will@kernel.org>, Paolo Bonzini <pbonzini@redhat.com>,
	Jonathan Corbet <corbet@lwn.net>, Shuah Khan <shuah@kernel.org>,
	Oliver Upton <oupton@kernel.org>, Dave Martin <Dave.Martin@arm.com>,
	Fuad Tabba <tabba@google.com>, Ben Horgan <ben.horgan@arm.com>,
	linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev,
	linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org,
	Peter Maydell <peter.maydell@linaro.org>,
	Eric Auger <eric.auger@redhat.com>
Subject: Re: [PATCH v10 01/30] arm64/sysreg: Update SMIDR_EL1 to DDI0601
 2025-06
Message-ID: <af4ZYVFsbYlEfdOu@J2N7QTR9R3>
References: <20260306-kvm-arm64-sme-v10-0-43f7683a0fb7@kernel.org>
 <20260306-kvm-arm64-sme-v10-1-43f7683a0fb7@kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260306-kvm-arm64-sme-v10-1-43f7683a0fb7@kernel.org>

On Fri, Mar 06, 2026 at 05:00:53PM +0000, Mark Brown wrote:
> Update the definition of SMIDR_EL1 in the sysreg definition to reflect the
> information in DD0601 2025-06. This includes somewhat more generic ways of
> describing the sharing of SMCUs, more information on supported priorities
> and provides additional resolution for describing affinity groups.

FWIW, these are all in ARM DDI 0487 M.b:

  https://developer.arm.com/documentation/ddi0487/mb/

Is anything later in the series going to depend on these fields, or
would everything behave correctly with the existing RES0 field
definitions?

> Reviewed-by: Fuad Tabba <tabba@google.com>
> Signed-off-by: Mark Brown <broonie@kernel.org>
> ---
>  arch/arm64/tools/sysreg | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm64/tools/sysreg b/arch/arm64/tools/sysreg
> index 9d1c21108057..b6586accf344 100644
> --- a/arch/arm64/tools/sysreg
> +++ b/arch/arm64/tools/sysreg
> @@ -3655,11 +3655,15 @@ Field	3:0	BS
>  EndSysreg
>  
>  Sysreg	SMIDR_EL1	3	1	0	0	6
> -Res0	63:32
> +Res0	63:60
> +Field	59:56	NSMC
> +Field	55:52	HIP

Reading the ARM ARM, HIP is arguably a backwards-incompatible change.

Do we expect to expose that to VMs, or just hide priorities entirely? I
suspect we probably want to require that the guest sees
SMIDR_EL1.SMPS==0, and not care about any of that.

Mark.

> +Field	51:32	AFFINITY2
>  Field	31:24	IMPLEMENTER
>  Field	23:16	REVISION
>  Field	15	SMPS
> -Res0	14:12
> +Field	14:13	SH
> +Res0	12
>  Field	11:0	AFFINITY
>  EndSysreg
>  
> 
> -- 
> 2.47.3
> 
