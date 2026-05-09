Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BCE638A738;
	Sat,  9 May 2026 12:47:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778330844; cv=none; b=bSBG6rv61x9PG0hKCsScrmEFoe23wp0rq2YWh/yZqIea3u90qqta4mJRLuRdQVARQkEY1DZMTeY3k+t4rGRWVILHBiuUMyxD/Dj7gAvLz3MVevSNenoBaZKDGuWjvjoQKdLNnOVDXOS9XyU93Y+iJNx77j6qNoDw2BCe8I4G7Js=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778330844; c=relaxed/simple;
	bh=bjnVrpCpo0m72zsdeb94/Sm1bj4caCUs1qTqzYnY6r0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gjyU788S3CT1NUkueMXQI3tqzKrfMVvCGaMfkQHt6rgyPKIccQJNaNKK0gFZdiTPwGGLT6oMk3wdxpRSZKB6mdWWnaCV4E/Gib3MjQhT/uq2Fe7lw6Bo25xNIVZZcDUcVlORhEE8IrXe3bxFkXJfyLbPdpoR2UtJ7G+iNBW8HO4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nXEiE9JL; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nXEiE9JL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 54FB7C2BCC7;
	Sat,  9 May 2026 12:47:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778330844;
	bh=bjnVrpCpo0m72zsdeb94/Sm1bj4caCUs1qTqzYnY6r0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=nXEiE9JL5pdwcek2XgkojTHdLlJxIV5PHOw/nWAU4KPuNjQdliWGkqdns2rdV33eP
	 /Zf8beKmk+tZtunNtRQzSoJ2nzjTSJ3s/hWvDY4yir3d3Dv146settdnfHVbqg5FmE
	 iXstJ3jF7r+0oD2ULtLVvGUYJBbh8BqD3YJYSD6p0FEdK7COu+LOLa68vanDY5t52y
	 5TBmPIfPuIyGSQdxfRfQ1cMApgzur3A8rxIhjt9kMTZRuHA2UuU0iWvVO2c3s0pLfl
	 fomrw54L72S+rs45abi2/a+LstezamoHWVmBPFRqOrMhq6AUPWHbjbQbOB4LHQRqBF
	 qxvnzSrjImZZw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	Sean Christopherson <seanjc@google.com>,
	Alexander Bulekov <bkov@amazon.com>,
	Fred Griffoul <fgriffo@amazon.co.uk>,
	stable@vger.kernel.org,
	Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH 6.12.y] KVM: x86: Fix shadow paging use-after-free due to unexpected GFN
Date: Sat,  9 May 2026 08:46:48 -0400
Message-ID: <20260509122858.58d41a55a7f2.re-kvm-x86-shadow-paging-uaf-6.12@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260505065956.194882-1-pbonzini@redhat.com>
References: <20260505065956.194882-1-pbonzini@redhat.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> [PATCH 6.12.y] KVM: x86: Fix shadow paging use-after-free due to unexpected GFN

Queued for 6.12.y, thanks.

--
Sasha
