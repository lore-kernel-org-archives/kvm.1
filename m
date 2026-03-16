Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44489301004;
	Mon, 16 Mar 2026 17:37:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773682680; cv=none; b=OGy2bniN6iLuUSztd2B5zsBadHicsFKKXKBP8tsXlGdKeaDh2My5oCwO9sYoG6EMvCYHqogpLyUiZA30AIznCM7dT04mJbNPiJwH1LiQqMtnlGEX+EFg7kQRTtnSbWyVQ92esqLnNVxdMdCtX69krlcTLg/f2WvSNQxeUyF+xM8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773682680; c=relaxed/simple;
	bh=gYDdfJFrV4JvoiEsVUAKvxfIEhze1CHZO5RF5mlKtu8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AV4VdpAOrOQqTtjK+vgz+zJHXlQnIZsG6/XAabieNphLVVklHMBT9e3X4kYu5N5Q2hhFkDJPqtxFAZxA9dMtGYrblboKp/xN+jsg8OakzhrnNFArf19a12Ip8E1zlZUEZHA+MkMrhHO4XRwphSt2jq/1bIG6tvIygwrDA7L0QNU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7857314BF;
	Mon, 16 Mar 2026 10:37:51 -0700 (PDT)
Received: from arm.com (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 108903F73B;
	Mon, 16 Mar 2026 10:37:54 -0700 (PDT)
Date: Mon, 16 Mar 2026 17:37:52 +0000
From: Catalin Marinas <catalin.marinas@arm.com>
To: Mark Brown <broonie@kernel.org>
Cc: Marc Zyngier <maz@kernel.org>, Joey Gouly <joey.gouly@arm.com>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Will Deacon <will@kernel.org>, Paolo Bonzini <pbonzini@redhat.com>,
	Jonathan Corbet <corbet@lwn.net>, Shuah Khan <shuah@kernel.org>,
	Oliver Upton <oupton@kernel.org>, Dave Martin <Dave.Martin@arm.com>,
	Fuad Tabba <tabba@google.com>, Mark Rutland <mark.rutland@arm.com>,
	Ben Horgan <ben.horgan@arm.com>,
	linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev,
	linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org,
	Peter Maydell <peter.maydell@linaro.org>,
	Eric Auger <eric.auger@redhat.com>
Subject: Re: [PATCH v10 02/30] arm64/fpsimd: Update FA64 and ZT0 enables when
 loading SME state
Message-ID: <abg_8FUj7CAjNkuO@arm.com>
References: <20260306-kvm-arm64-sme-v10-0-43f7683a0fb7@kernel.org>
 <20260306-kvm-arm64-sme-v10-2-43f7683a0fb7@kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260306-kvm-arm64-sme-v10-2-43f7683a0fb7@kernel.org>

On Fri, Mar 06, 2026 at 05:00:54PM +0000, Mark Brown wrote:
> Currently we enable EL0 and EL1 access to FA64 and ZT0 at boot and leave
> them enabled throughout the runtime of the system. When we add KVM support
> we will need to make this configuration dynamic, these features may be
> disabled for some KVM guests. Since the host kernel saves the floating
> point state for non-protected guests and we wish to avoid KVM having to
> reload the floating point state needlessly on guest reentry let's move the
> configuration of these enables to the floating point state reload.
> 
> We provide a helper which does the configuration as part of a
> read/modify/write operation along with the configuration of the task VL,
> then update the floating point state load and SME access trap to use it.
> We also remove the setting of the enable bits from the CPU feature
> identification and resume paths.  There will be a small overhead from
> setting the enables one at a time but this should be negligible in the
> context of the state load or access trap.  In order to avoid compiler
> warnings due to unused variables in !CONFIG_ARM64_SME cases we avoid
> storing the vector length in temporary variables.
> 
> Signed-off-by: Mark Brown <broonie@kernel.org>

Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
