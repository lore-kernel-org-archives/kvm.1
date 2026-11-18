Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=217.140.110.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795000677;
	b=PabGDRFCtwKHXMx7EkTPiLgNnvcHVaRisalzmgiSMs1CJYNQYf1sgH1BTKuHZpbCmTX2
	 3t0Kb3aA9z3J3Oi+RX3WWzuiEF6tY6AswShTXcymNB6VlF7sCmDwGQG6hqlD1hs5fpZO7
	 4EWISS0IzUvcsV9LNa+illgzqirdn32Ci2Y4jZds/VV8UmsztFYyHeTwp831poQz/oRzV
	 X+AryQKNj5M1f4Efv+ypdcLvb+Ikha0Ow+OiOMo0a18F66V/zCvWL3k8qax3HBjvOZLrA
	 fMT+N3bcpqFBzHYFci3VjUOhVEKJz+jmknw0yji9L5NKzWgt7zuJ/sKfcPca3sLjhFQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795000677;
	h=DMARC-Filter:Received:Received:DKIM-Signature:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Type:Content-Disposition:Content-Transfer-Encoding;
	bh=yV5ZF4ovd04Yk8LO1jsbdhbZodkcuM8PKaJ/YNDNZQg=;
	b=eGAdpovgZnaJ3h18nd+E+Uy3zqpHyHlj/v4zz1/+wE3OLqxws+sJqVJCWdFC7IKjUuRo
	 jMstZT7ltcy96jR3IvO+pPOutPpSitkf01gfFs3au9sHrVE9JwRiEPEDq16ovcUbFw3hi
	 CmmpeXpYRm/XVoLgnu2Qdq6+zNYSC6UzFU8qGQt6LBwpw23u8adEFWnITaSVvdLrHG+Dj
	 ymsq09cnXGbFRHLKP6/vKfa7W/fZvaCMUPmGyX6lu7vk8repirU1T1a5gdpWgWxIHOTUZ
	 oc4eBPzttvRIZmZj+5zzXN7P6gQZGRs6eVuTJQG2geZwr9FUhEpQ+WiN9cww5xwUzCw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=arm.com;
	spf=pass smtp.mailfrom=arm.com;
	dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=jDHxUj55;
	arc=none smtp.remote-ip=217.140.110.172
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66FF9606A325;
	Wed, 18 Nov 2026 11:17:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 66FF9606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=jDHxUj55
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id CF7061596;
	Wed, 18 Nov 2026 03:17:53 -0800 (PST)
Received: from LeoBrasDK.cambridge.arm.com (LeoBrasDK.cambridge.arm.com [10.2.212.21])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id DDB3B3F673;
	Wed, 18 Nov 2026 03:17:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1795000676; bh=cA7Cw/mcdSfEIqCAekaqUsnbbh0sl7jqa85TKPMypr0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=jDHxUj551E/KPCST/go5rVjQPgWgAkUHRoGAvKwdoMYjgqDZPprH6PrdXL02Nnxak
	 H2iaMuUmpU3dwgn3hQOrhvtRfhuAupbSI+Bl0YL9Q0GzqAmwlANoAxR6Baa9Sdccc4
	 I6ExOfuMwwovYmqX7gLYlc5424IU6sfuiImDo73A=
From: Leonardo Bras <leo.bras@arm.com>
To: Colton Lewis <coltonlewis@google.com>
Cc: Leonardo Bras <leo.bras@arm.com>,
	Marc Zyngier <maz@kernel.org>,
	Oliver Upton <oupton@kernel.org>,
	Joey Gouly <joey.gouly@arm.com>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Zenghui Yu <yuzenghui@huawei.com>,
	Fuad Tabba <fuad.tabba@linux.dev>,
	kvmarm@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 1/2] KVM: arm64: Fix inverted E2H0 check for HCR_EL2.NV1
Date: Wed, 18 Nov 2026 11:17:49 +0000
Message-ID: <av2JXKl7tBFPd_gD@LeoBrasDK>
X-Mailer: git-send-email 2.56.1
In-Reply-To: <20261117204343.4017815-1-coltonlewis@google.com>
References: <20261116200418.3535619-1-coltonlewis@google.com> <20261116200418.3535619-2-coltonlewis@google.com> <avyNBn24sLjxrfgR@LeoBrasDK> <20261117204343.4017815-1-coltonlewis@google.com>
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

On Tue, Nov 17, 2026 at 08:42:19PM +0000, Colton Lewis wrote:
> Leonardo Bras <leo.bras@arm.com> writes:
> 
> > Maybe feat_nv2_e2h0_not_res0(). What do you think?
> 
> Agreed on renaming it. Since HCR_EL2.NV1 is the bit marked RES0 (while
> ID_AA64MMFR4_EL1.E2H0 is the signed ID field controlling it), I renamed
> the helper to feat_nv2_nv1_not_res0() in v2.
> 
> -- Colton

Awesome! Thanks!
Leo
