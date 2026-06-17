Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B7C0379ECD;
	Wed, 17 Jun 2026 19:15:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781723703; cv=none; b=kdCd2vfA9vsrkkM98gDGfd2n36gCh0JwEhRZraDE4XC3r13q7HN76tfIAfzkKjGP4hWIYQyxXu0W7V9P67uj3Lj2ShslSLGhmcrMggaQ9VWQQAJEfxkx7XDaDhGWWrJghZ0grvAEyTHgjH15BaLlGl3TzKanz3rfYtxMWa+2KHg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781723703; c=relaxed/simple;
	bh=U/JjWDaNTGpaVDDjDb7/UO/EuFA3dV5VcowRISEDLcY=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=N4EGGBsGzcP+j9cocVaZ9SdKOyKSOj5kc8L4CdjXUb0CIqSEBIi7u9g2xJlZJgWHAj4zasesmnHYQOMzOisviIcDJT+Sn+hGx22jpiYRS8+8oXZRJFsH1Cx0aY9kCt6/3De4N3q0G1q6IEI6bTbyJhVTyNP+v56bD5WEyzOrGlA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JeZ2uI+Y; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JeZ2uI+Y"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2655A1F000E9;
	Wed, 17 Jun 2026 19:15:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781723702;
	bh=FASyi1AWkm+i6K2loGoBP4D8Pk6x5oWdo88DHdM7e3M=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc;
	b=JeZ2uI+YYS81CYkYXl5rr2DX06e0pb02WFbd4Q04fu1pKRXGLh3pO3L4+aa4/PnzA
	 4IuAU/mVOpzj81LyZML8/JASJTgYhPYDnt5EIqtenZjzcbts/PKm7jpDWHMuQsBRbe
	 yNDdcZSM+FjrFVahUrWVuSB+Nsb6u/Q9UU1dgQSiCOUwy4JY0ZFzY/6M5kzk5UPRFQ
	 uSbpUhe0KceTihL1nm2a2u35+SlHk7z/EFy8XkkbavXnHJNUCarmCUNHux4krTx4rd
	 SMGDkLWdxMkRfM57lgxgr8+E1mfQR94ZuAVgDbUKK9VtAApntrP93yMu/CXgltvfpb
	 YS+96iLSJ6fqQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 569AF3931008;
	Wed, 17 Jun 2026 19:14:57 +0000 (UTC)
Subject: Re: [GIT PULL] virtio,vhost,vdpa: features, fixes
From: pr-tracker-bot@kernel.org
In-Reply-To: <20260617065516-mutt-send-email-mst@kernel.org>
References: <20260617065516-mutt-send-email-mst@kernel.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20260617065516-mutt-send-email-mst@kernel.org>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/mst/vhost.git tags/for_linus
X-PR-Tracked-Commit-Id: 8cb2c9285e4ce9154f45fb15633ebd45dfd8d9cf
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: d44ade05aa21468bd30652bc4492891b854a400a
Message-Id: <178172369584.1775335.8856194024948624969.pr-tracker-bot@kernel.org>
Date: Wed, 17 Jun 2026 19:14:55 +0000
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, kvm@vger.kernel.org, virtualization@lists.linux-foundation.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, a0yami@mailbox.org, ammarfaizi2@openresty.com, arnd@arndb.de, chenhuacai@kernel.org, chenhuacai@loongson.cn, christfontanez@gmail.com, Damir.Shaikhutdinov@opensynergy.com, david@kernel.org, den@openvz.org, enelsonmoore@gmail.com, eperezma@redhat.com, ethan@ethancedwards.com, evg28bur@yandex.ru, filip.hejsek@gmail.com, francesco@valla.it, graf@amazon.com, harald.mommer@oss.qualcomm.com, jasowang@redhat.com, jiri@nvidia.com, johan@kernel.org, johannes.thumshirn@wdc.com, lingshan.zhu@kernel.org, luis.hernandez093@gmail.com, lulu@redhat.com, mhi@mailbox.org, michael.bommarito@gmail.com, mikhail.golubev-ciuchea@oss.qualcomm.com, mkl@pengutronix.de, mst@redhat.com, mvaralar@redhat.com, nathan@kernel.org, oleg@redhat.com, pawel.moll@arm.com, physicalmtea@gmail.com, polina.vishneva@virtuozzo.com, q.h.hack.winter@gmail.com, r
 osenp@gmail.com, schalla@marvell.com, shuangyu@yunyoo.cc, stefanha@redhat.com, vattunuru@marvell.com, yanlonglong@kylinos.cn, yichun@openresty.com, yui.washidu@gmail.com, yuka@umeyashiki.org, zhangtianci.1997@bytedance.com
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

The pull request you sent on Wed, 17 Jun 2026 06:55:16 -0400:

> https://git.kernel.org/pub/scm/linux/kernel/git/mst/vhost.git tags/for_linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/d44ade05aa21468bd30652bc4492891b854a400a

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
