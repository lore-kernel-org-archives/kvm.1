Received: from mail.8bytes.org (mail.8bytes.org [85.214.250.239])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AF4136492D
	for <kvm@vger.kernel.org>; Tue, 23 Jun 2026 09:30:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.250.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782207029; cv=none; b=uZN8k4w/ZAIBps7RzulfT5GmIM3VblerQ2HYxR8dTPSRzygETK4woUwOMLQLLiBnR5VdqR6EY/dnq2BW7MMH36XlKfwkViINPWqRt6+7d+979g6gsbuv6TKbqlJ7SAsibaeNcHLrLqFWFOqRzYtPWzsknAMG1zXPVp/yf56Ooxs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782207029; c=relaxed/simple;
	bh=3TGtvwHaexW+UPF8Q+KYHXgqlpvybHcl8QruooTC228=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YtoL1pDGmjtLtnMHGIjT8r2BZe0tco+8iYRB4kYRWb3aA+Y5j7QY4BTo2SkYGDT6RFSgikMMtOL0djujXOgApg1m9jB/7pkdYrDIbpf6ZWCrqhYAS1zxmzjCsJ5DIH3FPYbYhmLTdRVNXtmYN96//0ZmFPHSb2Mxnga2I7les2Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org; spf=pass smtp.mailfrom=8bytes.org; arc=none smtp.client-ip=85.214.250.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=8bytes.org
Received: from 8bytes.org (p200300f6af4fc500cc95bb0c16cd4e45.dip0.t-ipconnect.de [IPv6:2003:f6:af4f:c500:cc95:bb0c:16cd:4e45])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.8bytes.org (Postfix) with ESMTPSA id 69D33203D3D;
	Tue, 23 Jun 2026 11:30:26 +0200 (CEST)
Date: Tue, 23 Jun 2026 11:30:25 +0200
From: =?utf-8?B?SsO2cmcgUsO2ZGVs?= <joro@8bytes.org>
To: sashiko-reviews@lists.linux.dev
Cc: kvm@vger.kernel.org
Subject: Re: [PATCH 2/4] kvm: sev: Unmap pages in correct order in
 sev_gmem_post_populate()
Message-ID: <ajpSF6HyhgBA3uV3@8bytes.org>
References: <20260623091556.1500930-1-joro@8bytes.org>
 <20260623091556.1500930-3-joro@8bytes.org>
 <20260623092417.5964D1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260623092417.5964D1F000E9@smtp.kernel.org>

On Tue, Jun 23, 2026 at 09:24:16AM +0000, sashiko-bot@kernel.org wrote:
> Should this second instance be updated to reverse the unmap order as well to
> prevent kmap stack corruption?

Yes, it should. Updated for v2.
