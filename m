Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB6FF2D12EE;
	Fri,  3 Jul 2026 07:37:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783064275; cv=none; b=YxJAf2Uoj2J2FzV71Au/s7OL5wa/l9PuWmrsEi3/SoED0Vn55IuDKGTjcIxG50l/WLThWdvj8ygKI9fsGAw1O/91Luq1I4aaQM8VdGgkSWHLo1jTqpQ/YBiIFcM1oDRoTZr7K0x5q78NY/M+sOktHteCtRVBrG8x40K15645iYw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783064275; c=relaxed/simple;
	bh=/zEdjDHHDOZlLYDj/HrAahZZ9YvreIDGoxRLp/b3nmc=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=GGt190/paI8ppa/vkzHoMhH7vj2FjlLiaXho3tJL5WVg+G9SXLyGzNhzqYKDWN612x/NqkfDqn6C2ZwYBAI8jS6tntZXySna6YiIwTVs5HetdDAF9U92csY1UroNZY6Uv2F/rjXxmyTey+B1E/TlUjzhDIX3grldEVFXVJsqP4o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=E7fzZHQj; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="E7fzZHQj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A43E41F000E9;
	Fri,  3 Jul 2026 07:37:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783064274;
	bh=BNjc89ZTwEE6sAh5F09SyQEpJODWyJuS+YsA1L114gk=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc;
	b=E7fzZHQjHbuqRbfY5w8N/zq/LIGZMJY1SK41CeUUib7CZ4WxWm5MqtADiZytRVf8k
	 B6AmxstGKgmn9k/gnWEMrYU/U8prhEH9/KBSrez2/6+NEuF1ehCnCime+EeHT7H/Vc
	 3uPHNJ7e7l0I0rxnW+Hr072aIgsDpQNOHShnhFE32hDNXp6obtBsRggP9gjJ9qOPxF
	 gm5mTrJ5kP99/8S/EVRiBrZq6SeYg8SxwOWKk+cApIcZjDHtKLqJQAQJJvgyCJU9Xh
	 uvtmeyMNf/xe4qOOa2+jWsvz9DD00nDyID+u4LEyyFtC11nrDHmkAIGykMv8cZ9zSV
	 H59njUBru/Yjw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 56D2B39389CB;
	Fri,  3 Jul 2026 07:37:38 +0000 (UTC)
Subject: Re: [GIT PULL] Split <linux/mod_devicetable.h> in per subsystem headers
From: pr-tracker-bot@kernel.org
In-Reply-To: <akdIS8mW2IubUWQh@monoceros>
References: <akdIS8mW2IubUWQh@monoceros>
X-PR-Tracked-List-Id: <devicetree.vger.kernel.org>
X-PR-Tracked-Message-Id: <akdIS8mW2IubUWQh@monoceros>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/ukleinek/linux.git tags/device-id-rework
X-PR-Tracked-Commit-Id: 995832b2cebe6969d1b42635db698803ee31294d
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: d2c9a99135da931377240942d44f3dea104cedb8
Message-Id: <178306425679.2510133.17664517627067155845.pr-tracker-bot@kernel.org>
Date: Fri, 03 Jul 2026 07:37:36 +0000
To: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Nathan Chancellor <nathan@kernel.org>, Nick Desaulniers <nick.desaulniers+lkml@gmail.com>, Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>, Raag Jadav <raag.jadav@intel.com>, Sohil Mehta <sohil.mehta@intel.com>, Dave Hansen <dave.hansen@linux.intel.com>, Rob Herring <robh@kernel.org>, Saravana Kannan <saravanak@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>, Andi Shyti <andi.shyti@kernel.org>, linux-kernel@vger.kernel.org, Yemike Abhilash Chandra <y-abhilashchandra@ti.com>, Mauro Carvalho Chehab <mchehab@kernel.org>, linux-media@vger.kernel.org, Nicolas Frattaroli <nicolas.frattaroli@collabora.com>, Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Heiko Stuebner <heiko@sntech.de>, linux-rockchip@lists.infradead.org, linux-sound@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Dani
 lo Krummrich <dakr@kernel.org>, driver-core@lists.linux.dev, Jonathan Cameron <jic23@kernel.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>, Pei Xiao <xiaopei01@kylinos.cn>, Shashank Balaji <shashank.mahadasyam@sony.com>, Ben Horgan <ben.horgan@arm.com>, Johan Hovold <johan@kernel.org>, linux-usb@vger.kernel.org, Nikita Kravets <teackot@gmail.com>, Hans de Goede <hansg@kernel.org>, Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>, platform-driver-x86@vger.kernel.org, devicetree@vger.kernel.org, linux-i2c@vger.kernel.org, Daniel Scally <dan.scally@ideasonboard.com>, Sakari Ailus <sakari.ailus@linux.intel.com>, Tianrui Zhao <zhaotianrui@loongson.cn>, Bibo Mao <maobibo@loongson.cn>, Huacai Chen <chenhuacai@kernel.org>, WANG Xuerui <kernel@xen0n.name>, kvm@vger.kernel.org, loongarch@lists.linux.dev, Geert Uytterhoeven <geert@linux-m68k.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Mark Brown <broonie@ker
 nel.org>, Takashi Sakamoto <o-takashi@sakamocchi.jp>, Wolfram Sang <wsa+renesas@sang-engineering.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 3 Jul 2026 08:04:04 +0200:

> https://git.kernel.org/pub/scm/linux/kernel/git/ukleinek/linux.git tags/device-id-rework

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/d2c9a99135da931377240942d44f3dea104cedb8

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
