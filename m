Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=65.109.113.108
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794529052;
	b=TGQKSbYFeZiW43pAxBT468NsVjWSf5HBue9t938DG6NW/i165SWXJvUfl3uu1uIXMGgi
	 Ueyz1bk+2XmOY6xaVTidtKaeO4N+o6kFiyt5MdmhMbEX6xVem+ANcxSR1hdEYLz4lwIZ/
	 uaYXiijkHclIeZvmn1ENsgMZ/1fU17krPr8VoUQhSW7zl3Bt7BtIdWh7v57as1x//uD0i
	 9u+wmAqXaxPenRFqg8SVvnlv9YexDOn93RP/Nb5zwiN7yZtBdUkjAkLC/ZsYWR9MLbxM0
	 P6ezffEb27VnUccDDjWFuuTS1zk+zPYqTDaz5aSGnpbaE9g4SMXiSnnXO8ShggggDwQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794529052;
	h=DMARC-Filter:Received:X-Virus-Scanned:Received:DKIM-Signature:
	 Received:Date:From:To:CC:Subject:User-Agent:In-Reply-To:References:
	 Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=SF1gokFIlxA0lxb0bJ+7LJNNprQkzUbs5KhpdJOREYw=;
	b=d66Bvbj7kpl84fgQ9XKtQ5SMjannx52A18NNiVMsaW++9efOpXK/tUqsSYNI5taT9l7V
	 fkzQQcmiepLxWefwyxl4CfEwyRaUwGlT0PGvBlneLsHFhqF/PfctcCKwQww1SSPaLw91T
	 B7NH8u5VbMCiwsvU7MX97oacqxRXBbohaAXt9WLzz0r4Grx6+QPpb/sxzsuhumVQ5URL2
	 7qnA15dIb3G7VXN2cW5Mc/PuphpNMqPWnBqZV5PM3aH7IsjzvbjkCBYCtAHjIrfirhJRZ
	 NTTuvoq2CiuEtODPeQfrIbhiAMpH1N4QAn20N3SJpeq30hVv8zngJyguCooChEA4IWA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=alien8.de;
	spf=pass smtp.mailfrom=alien8.de;
	dkim=pass header.d=alien8.de header.i=@alien8.de header.a=rsa-sha256 header.s=alien8 header.b="WmWK/PpZ";
	arc=none smtp.remote-ip=65.109.113.108
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3A1F606A31C;
	Fri, 13 Nov 2026 00:17:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org F3A1F606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.a=rsa-sha256 header.s=alien8 header.b=WmWK/PpZ
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id D9D6140E0184;
	Fri, 13 Nov 2026 00:17:29 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id 99-WtVOz2-xU; Fri, 13 Nov 2026 00:17:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1794529046; bh=SF1gokFIlxA0lxb0bJ+7LJNNprQkzUbs5KhpdJOREYw=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:From;
	b=WmWK/PpZEeDacN+3DkBXx0z3t+3GNFgG6Sfyjsw25ZBFXr0FYH52/RpB4RtkPq38f
	 EeTBAC33QDCvolVTr1TNTfNk0TNSSxb7GZrOkwh1T6esRfyeyUeo5ncG8EmAeesJXy
	 QxhnVfIHu6U+HWBMfY1G5YioXpRjnvboE5odfUFGwg05XbsYo+PrlrrEeLqAI/EZFo
	 wkQCFm8E4GaW/JadkWXYiYxE2Ws+gY1wNI+UC1avd1NomtqH58zxC0cRMgcOTI6Cev
	 oz86YiyfshdbyrInn7ak8ZxnsY4U671QVUz1AwovPvO3AOM5NZvQCVV0VBxTriR55G
	 Bhr2zEGbVTGpsJTALFBCsE/pjHFLv1OoG0eM5kDug+ox/+fbHXElKHpuyZEmeFgkpq
	 f/Fc0TkVoq4JxVquhO7tEqinJjUuSUafk4WPrKEVCVCXPUYvu3Gv5p/PsLxqXvoQ2g
	 C7o4mfShBy61Zw13Upb13jXw47L/ZOiFXifA5+ZfBZKWmfhqoYr9KqC35WsWT4K/Gj
	 k08QimkqM7OkMdzBPBek2CtVxMezjEy8/gni65Bo69tKUqvZHXIj8GHHSK1FMjvM00
	 gwAspNJQvQKLcVp1jwLA901MSwxmlTnIA2Irux3/7NaHF7Zpob8CveqpStzNV2Icsd
	 Nx34V/T3xKBTqqHzugaTOcQo=
Received: from ehlo.thunderbird.net (mobile-166-172-120-26.mycingular.net [166.172.120.26])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 9BE4A40E015B;
	Fri, 13 Nov 2026 00:17:12 +0000 (UTC)
Date: Fri, 13 Nov 2026 00:15:30 +0000
From: Borislav Petkov <bp@alien8.de>
To: Thomas Gleixner <tglx@linutronix.de>
CC: "H. Peter Anvin" <hpa@zytor.com>, Breno Leitao <leitao@debian.org>,
 Ingo Molnar <mingo@redhat.com>, Dave Hansen <dave.hansen@linux.intel.com>,
 x86@kernel.org, Sean Christopherson <seanjc@google.com>,
 Paolo Bonzini <pbonzini@redhat.com>, linux-kernel@vger.kernel.org,
 kvm@vger.kernel.org, vlad.wing@gmail.com, security@kernel.org,
 kernel-team@meta.com
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH_6=2E18=2Ey=5D_x86/cpufeatures=3A_M?=
 =?US-ASCII?Q?ake_X86=5FFEATURE_leaf_17_Linux-specific?=
User-Agent: K-9 Mail for Android
In-Reply-To: <87ik21sirc.ffs@fw13>
References: <20261111-stabe_srso-v1-1-45512320ba5e@debian.org> <20261112045703.GAavVHH8KA2yyCU7oc@fat_crate.local> <9492bce8-aab7-4982-8a0c-7d736c745e12@zytor.com> <29B14106-19E4-4589-BE40-3D42BA646CE3@alien8.de> <87o6btsl4g.ffs@fw13> <20261112233327.GBavZMx2etyTFh1be4@fat_crate.local> <87ik21sirc.ffs@fw13>
Message-ID: <804E3306-237D-4923-BF96-9E7C85BB933D@alien8.de>
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable

On November 13, 2026 12:00:07 AM UTC, Thomas Gleixner <tglx@linutronix=2Ede=
> wrote:
>Yes=2E The fact that it's ridiculous that we still have to debate this=2E

I don't think anyone disagrees=2E

>The time wasted on that, the time wasted by people to decode the subtle
>bugs and the amount of AI tokens wasted to come up with more duct tape
>fixes is at least an order of magnitude more expensive than funding the
>completion of the overhaul=2E

There's a great proverb in my native tongue which goes something like this=
: whack the saddle so that the horse hears and acts on it=2E

Yeah, I'm just a saddle=2E :-)

>But I just "work" here so I might be missing something important which
>justifies that =2E=2E=2E

Same here=2E Lemme continue working towards it and we'll see where we get=
=2E I'll whack scattered=2Ec and then continue working on Ahmed's pile=2E U=
nless you have a different suggestion=2E=20

Thx=2E

--=20
Small device=2E Typos and formatting crap
