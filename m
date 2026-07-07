Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACF44436BCA
	for <kvm@vger.kernel.org>; Tue,  7 Jul 2026 16:44:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783442695; cv=none; b=canr5zTQC5ccjkYelyGDKhK5VziO+ZY8yCU46WtiAZc5gZh0XeYy7BJNaBsYKPUlcp4+oEr3nhN7JF9+uIvMUO2yqVB0wn9zbE7MURUXdZoYuRHXeN82vXTajTr26Vyu9LuvqUzpJz7F6Wr6aGGqmmKJcntvSr2Gxq719P568rs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783442695; c=relaxed/simple;
	bh=4322duvzDJtYWK0yulJTCYZ1P/nPZl1UiX1Syygi8D8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sBMdmsX5d8B2WYd8rkF3aRYoOykci0dehlF4yyVK2TIVR6tZLRDZu33tYed6DOQG7tzj0GOrMpKaAcQYMY5TsICLH218QHkSY6CvtGjuo97gQGTicbyKSZt7ET0eVGwIGSK18Eu4QyZkDRvXg8t0ovqLntPu6B40xI0C+G2RfAc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Le6aDwko; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Le6aDwko"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7868D1F00A3A;
	Tue,  7 Jul 2026 16:44:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783442694;
	bh=Vb+uzQslXNnzFN8dPaHgq6RUHJYsFcy6X4K3rf4mJF0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Le6aDwkoKlfMT1NhMCg5Wvgg3JmjiLcfADQZOs6je0xZQBKNVpVQboR+K8SggDUfI
	 vpIYaMaTqlp86Zyn+9HH6+mVSFcywPAb+/MSOdUBAZVe6YAAzd/r1mt65HA34tVyy4
	 LwycDgj4rMhMj+HyDBVUZRZyvEyvcIUfc94uqApohoPjcRAMvtZliA/u+A0xjy0hl/
	 AzlZ4WKlrlNeOXRopIg9aC4usKVSBaduErqDci2L0bsmRmHDntIQedJDdsBU9WOAE/
	 8QU7KHSO5yR07Y+y+JQN4Z/v/JYp1XQFDTG23C7dLORvsTCb6A8YxIqqxvKaGECgxM
	 CummkJHAjU6zw==
Received: from sofa.misterjones.org ([185.219.108.64] helo=valley-girl.lan)
	by disco-boy.misterjones.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <maz@kernel.org>)
	id 1wh8ui-00000002VO8-2cNy;
	Tue, 07 Jul 2026 16:44:52 +0000
From: Marc Zyngier <maz@kernel.org>
To: kvm@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	Marc Zyngier <maz@kernel.org>
Cc: Steffen Eiden <seiden@linux.ibm.com>,
	Joey Gouly <joey.gouly@arm.com>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Oliver Upton <oupton@kernel.org>,
	Zenghui Yu <yuzenghui@huawei.com>,
	Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] KVM: arm64: Fix propagation of TLBI level in kvm_pgtable_stage2_relax_perms()
Date: Tue,  7 Jul 2026 17:44:47 +0100
Message-ID: <178344263830.1901049.2047368013580972483.b4-ty@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260707162935.1900874-1-maz@kernel.org>
References: <20260707162935.1900874-1-maz@kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 185.219.108.64
X-SA-Exim-Rcpt-To: kvm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, maz@kernel.org, seiden@linux.ibm.com, joey.gouly@arm.com, suzuki.poulose@arm.com, oupton@kernel.org, yuzenghui@huawei.com, broonie@kernel.org
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false

On Tue, 07 Jul 2026 17:29:35 +0100, Marc Zyngier wrote:
> Assigning the invalidation level (an s8 value) with TLBI_TTL_UNKNOWN
> (a 32bit signed value) is not ideal, to say the least. Instead of
> this, only pass TLBI_TTL_UNKNOWN to __kvm_tlb_flush_vmid_ipa_nsh()
> when we know for sure that we don't have a provided level.
> 
> 

Applied to fixes, thanks!

[1/1] KVM: arm64: Fix propagation of TLBI level in kvm_pgtable_stage2_relax_perms()
      commit: 8d187d4b33c262c0f3e44842553521151d8629e8

Cheers,

	M.
-- 
Without deviation from the norm, progress is not possible.


