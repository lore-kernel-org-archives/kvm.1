Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70A47219A81;
	Fri, 13 Feb 2026 20:18:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771013884; cv=none; b=Y7bZuXpC+g1o0bOc5jybokLPaHid0fm2CWlqtvqd5tmaQktRpFlmTUyPqLBIvJICppa3wWAyiJjYgB8MQrvN2ehm2NjrTzvmyGxCx2a1VdF6Vz5N1RZc5bG0ew0M+YqtNHRhnQyr4lF++LK/9VoTtxvXlGwpYI4AXk18yOEmlfk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771013884; c=relaxed/simple;
	bh=HMsprEr0dyBLg0uFzoHbSkfaujjhcOnGu3Pvq12CrGc=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=IEgbHPfyvNeYQLi/DG1Awr9+Xe7GM5bDcPPv+kq7DkLARn/Qh87o9Gsp9WeEMrJaV4HmN8COJztUwluDI2bkcIOPRVt/Qyhvp4bv0fTl+TlMjf9u2Q0UgQPG4cmaGECMbG6ct0Y0eWiNbTJskiozoKdPFInnIbC/HZMZjbpCWhY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=N/fRggaH; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="N/fRggaH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B3AAC116C6;
	Fri, 13 Feb 2026 20:18:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771013884;
	bh=HMsprEr0dyBLg0uFzoHbSkfaujjhcOnGu3Pvq12CrGc=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=N/fRggaHx9S5tzgpnzVbwhhrR4yvNwkpv2HNG2kr0t7eWx5JowEVQzjSNdZ/KIqmC
	 GoajvbE7j2XJiR8uA5d9+TLZHvOwT/iDbbsJdfd7A1a+W/JOWcwbE6jILRHiySuQEd
	 Akv7PBzgcdgDo95aLonHfvOCS/fIBV4fGIfKsoFF7oEkNZALx4M/LCm8maVUvZOpK/
	 3eN44T9LYVVWIfdswr6vWnLcItzH+caw0K8PqwAZsLg/fg/m0X7EXpJhG/HemiWS6P
	 y/+QDzUq8VYDOFWpydVGUy89qQBg7qCUk3OJ7O9T7dotTpAp22vo1g3UG4zWEoMlrX
	 icyMTJBWqGVIw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 0B0AC3811A44;
	Fri, 13 Feb 2026 20:17:59 +0000 (UTC)
Subject: Re: [GIT PULL] virtio,vhost,vdpa: features, fixes
From: pr-tracker-bot@kernel.org
In-Reply-To: <20260213050602-mutt-send-email-mst@kernel.org>
References: <20260213050602-mutt-send-email-mst@kernel.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20260213050602-mutt-send-email-mst@kernel.org>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/mst/vhost.git tags/for_linus
X-PR-Tracked-Commit-Id: ebcff9dacaf2c1418f8bc927388186d7d3674603
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: a353e7260b5951a62dce43630ae9265accd96a4b
Message-Id: <177101387763.2542361.9540347559826877081.pr-tracker-bot@kernel.org>
Date: Fri, 13 Feb 2026 20:17:57 +0000
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, kvm@vger.kernel.org, virtualization@lists.linux-foundation.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, arnd@arndb.de, bartosz.golaszewski@oss.qualcomm.com, bp@alien8.de, eperezma@redhat.com, jasowang@redhat.com, jon@nutanix.com, kshankar@marvell.com, leiyang@redhat.com, lulu@redhat.com, maobibo@loongson.cn, mst@redhat.com, m.szyprowski@samsung.com, seanjc@google.com, sgarzare@redhat.com, stable@vger.kernel.org, thomas.weissschuh@linutronix.de, viresh.kumar@linaro.org, xiyou.wangcong@gmail.com, zhangdongchuan@eswincomputing.com
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 13 Feb 2026 05:06:02 -0500:

> https://git.kernel.org/pub/scm/linux/kernel/git/mst/vhost.git tags/for_linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/a353e7260b5951a62dce43630ae9265accd96a4b

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
