Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACE683161BA;
	Sat, 27 Jun 2026 16:07:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782576465; cv=none; b=SPNlPXe9V5FNqbuWDc0OVJbZ3tVfVun5Kcqfg542eaQexdDvNJW/BB+3kWOk28nv1YmlUyZmU3npxu1NzJD+jiQdGjK44/RyR/UVBjkoy4vdioRoS4bREauJiu4p86FaeQgOy7HNrhW7+M0zj5U1zz4FMHdFr9GBoF3sivP2fqM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782576465; c=relaxed/simple;
	bh=kbXE+e2kShUdFQUZEtzV5kb5kIHvO0+olg3vo8dAYAI=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:To:From:Subject:
	 References:In-Reply-To; b=QVIWMeaa2RUosxF2ZKkdx5Qbzu4wuJjA+f3NDKn1y0aqXogXgBvq2l1Shxt6lGEzla+KUv6ZpKEwK6t7BmXWcar0u0In155TyXTsu6x/6fCxfjF/EJy+/AT05+iz7W2sxrKVf7F1Rxiv0Gz7onQCEPjdcD1tJa12M9U780ta9SU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Qw2Y59Rm; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Qw2Y59Rm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 24B671F000E9;
	Sat, 27 Jun 2026 16:07:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782576463;
	bh=Eai9illNnwIVHHx82Y8oRRChAijNkCdc6Gtuf6pgPNA=;
	h=Date:Cc:To:From:Subject:References:In-Reply-To;
	b=Qw2Y59RmKIirc9QicmPqL66sTrj2a2pRKQ4q1v06L1xA9E/C/n8ujusPhFM+JyAMq
	 Sc7C+LA2hGDEhdfXPP6JFmdPW/lxQo9uwCywxV3gUUCsoaqp/p8gFp8rSRqgPX9Rot
	 aq3TQmnmHDhFsytBp0U3bmY62h9aCkV7OgVPCbZZlU8BaFdjaz9P3zEBUeuvx5tPmD
	 4Tx2RvxcWeTQ2au9N+Wnor838KKBkB0xRChuAMilaNqmNIuEwn8ueK3uR1GU+mDUy3
	 YyRV47jAv1zDKiToKjdTIwjPqIKhSumFkr9k6T4RB7BOfeDsDOS70P4Gje9HvpGVAd
	 5T1h6xlOziCJQ==
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sat, 27 Jun 2026 18:07:32 +0200
Message-Id: <DJJYM56GLGXX.2L6RY669ZOJSC@kernel.org>
Cc: "Linus Torvalds" <torvalds@linux-foundation.org>, "Greg Kroah-Hartman"
 <gregkh@linuxfoundation.org>, "Mark Brown" <broonie@kernel.org>, "Nathan
 Chancellor" <nathan@kernel.org>, "Nick Desaulniers"
 <nick.desaulniers+lkml@gmail.com>, "Bill Wendling" <morbo@google.com>,
 "Justin Stitt" <justinstitt@google.com>, "Raag Jadav"
 <raag.jadav@intel.com>, "Sohil Mehta" <sohil.mehta@intel.com>, "Dave
 Hansen" <dave.hansen@linux.intel.com>, "Rob Herring" <robh@kernel.org>,
 "Saravana Kannan" <saravanak@kernel.org>, "Bjorn Helgaas"
 <bhelgaas@google.com>, "Rafael J. Wysocki" <rafael@kernel.org>, "Len Brown"
 <lenb@kernel.org>, "Andi Shyti" <andi.shyti@kernel.org>,
 <linux-kernel@vger.kernel.org>, "Yemike Abhilash Chandra"
 <y-abhilashchandra@ti.com>, "Mauro Carvalho Chehab" <mchehab@kernel.org>,
 <linux-media@vger.kernel.org>, "Nicolas Frattaroli"
 <nicolas.frattaroli@collabora.com>, "Liam Girdwood" <lgirdwood@gmail.com>,
 "Jaroslav Kysela" <perex@perex.cz>, "Takashi Iwai" <tiwai@suse.com>, "Heiko
 Stuebner" <heiko@sntech.de>, <linux-rockchip@lists.infradead.org>,
 <linux-sound@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
 <driver-core@lists.linux.dev>, "Jonathan Cameron" <jic23@kernel.org>,
 "Dmitry Torokhov" <dmitry.torokhov@gmail.com>, "Bartosz Golaszewski"
 <bartosz.golaszewski@oss.qualcomm.com>, "Pei Xiao" <xiaopei01@kylinos.cn>,
 "Shashank Balaji" <shashank.mahadasyam@sony.com>, "Ben Horgan"
 <ben.horgan@arm.com>, "Johan Hovold" <johan@kernel.org>,
 <linux-usb@vger.kernel.org>, "Nikita Kravets" <teackot@gmail.com>, "Hans de
 Goede" <hansg@kernel.org>, =?utf-8?q?Ilpo_J=C3=A4rvinen?=
 <ilpo.jarvinen@linux.intel.com>, <platform-driver-x86@vger.kernel.org>,
 <devicetree@vger.kernel.org>, <linux-i2c@vger.kernel.org>, "Daniel Scally"
 <dan.scally@ideasonboard.com>, "Sakari Ailus"
 <sakari.ailus@linux.intel.com>, "Minas Harutyunyan" <hminas@synopsys.com>,
 "Tianrui Zhao" <zhaotianrui@loongson.cn>, "Bibo Mao" <maobibo@loongson.cn>,
 "Huacai Chen" <chenhuacai@kernel.org>, "WANG Xuerui" <kernel@xen0n.name>,
 <kvm@vger.kernel.org>, <loongarch@lists.linux.dev>
To: =?utf-8?b?VXdlIEtsZWluZS1Lw7ZuaWcgKFRoZSBDYXBhYmxlIEh1Yik=?=
 <u.kleine-koenig@baylibre.com>
From: "Danilo Krummrich" <dakr@kernel.org>
Subject: Re: [PATCH v2 00/17] mod_devicetable.h: Split into per subsystem
 headers
References: <cover.1782490566.git.u.kleine-koenig@baylibre.com>
In-Reply-To: <cover.1782490566.git.u.kleine-koenig@baylibre.com>

On Fri Jun 26, 2026 at 8:00 PM CEST, Uwe Kleine-K=C3=B6nig (The Capable Hub=
) wrote:
> Uwe Kleine-K=C3=B6nig (The Capable Hub) (17):
>   mod_devicetable.h: Split into per subsystem headers
>   driver: core: Include headers for acpi_device_id and of_device_id for s=
truct device_driver
>   driver core: platform: Include header for struct platform_device_id

With the suggested rename,

Acked-by: Danilo Krummrich <dakr@kernel.org>
