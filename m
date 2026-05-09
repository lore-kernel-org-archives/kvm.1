Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD25932B989;
	Sat,  9 May 2026 12:47:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778330846; cv=none; b=ArslaZTDIgPUfaTanKtmwg72HCcQulNK94XZReQFRBW6XVsGh/2gNkblI4aMxTVbMQyWwCMAxDfrcLAcBBJc5RXpOhXKN0ouRPhShrDwEaFarRQSXZBB9NFnOu6DC8VMBzbjagtOkvAQLTE+qfc0EcaX1sgiy9T1iAMnR2vyzcc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778330846; c=relaxed/simple;
	bh=XK5mhAUBfu3WjNswiiSxlvINMO13NiggoMGvmD3JwPI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Z4EDqdOPNtB4Zqs0HOfEDY6UjJGnfSz96dMBfMLo4zvym35nk+6wxuDgHhmavOEb2GMTsWqg/MkkwcDkrIchCN/xFrC9v6Gol/mWC+/yY/y9lOZD15/1KjSUoy7mfAqWiz35FxhEzfQTAJcJkc/YK45gPHOs39Wrx1cijcNTBmU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jFZCRgUt; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jFZCRgUt"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A5CB5C2BCB4;
	Sat,  9 May 2026 12:47:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778330846;
	bh=XK5mhAUBfu3WjNswiiSxlvINMO13NiggoMGvmD3JwPI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=jFZCRgUtIv0K1nTk27PZNjynhpbIgfIQFGZCgtNVBiW6a+G4tdrOdr1SEf6Q8Ca86
	 k8dIA2xxEleOHhC0WMrXI1okEg2p87NPVBIdJgAWSyIFSkyd0eAu22GGQKUZeHsQbh
	 1535lK1qFLrbGQGPzUathroC51hl70NOrUMB7qtEqMZRimdxN/EUyy+awWqhH+q6IT
	 TCvRaDgTHiC2PwpQYEoXDCeD0ON80Fif2LrNdaOXxnptAcI5idCIXAfq+12blC/Uv+
	 DxingG9z2ol50OC0tojwJzjDJSK6cmUcratG8zE4th1dulWGINAWgb79ma7sDv1HYT
	 Y6giFrnnFzvkw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	Sean Christopherson <seanjc@google.com>,
	Alexander Bulekov <bkov@amazon.com>,
	Fred Griffoul <fgriffo@amazon.co.uk>,
	stable@vger.kernel.org,
	Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH 6.1.y] KVM: x86: Fix shadow paging use-after-free due to unexpected GFN
Date: Sat,  9 May 2026 08:46:50 -0400
Message-ID: <20260509122858.475f3b407568.re-kvm-x86-shadow-paging-uaf-6.1@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260505070812.221568-1-pbonzini@redhat.com>
References: <20260505070812.221568-1-pbonzini@redhat.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> [PATCH 6.1.y] KVM: x86: Fix shadow paging use-after-free due to unexpected GFN

Queued for 6.1.y, thanks.

--
Sasha
