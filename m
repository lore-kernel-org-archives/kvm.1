Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76ABD39D6E3;
	Mon, 23 Mar 2026 12:20:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774268402; cv=none; b=pLt2PLE4znCI4hyP9NRtcCX/8Qz+hMp2FiG+ptqIgc+e2WFq0xFzjRrPCJ6Xg+8rfbKpzfP5c9dEtYQkLsqWAhg+49vz5qGKmpKi63zzXc4vuKjK+SHUaNaar7enxKsPqWjYDT1GlgPIg3ug/uzkwU9pGmN83E6D2ajPKMe44GM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774268402; c=relaxed/simple;
	bh=6t/lhUuG9oxp6b5wO5q5zKnYzdevzI6wL/nLKMEmjro=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qs9qQ9MtczYVAgeIS8AklNSemSEw3nKe1pV1XzwggaNunZjdW+OTGEeerZDtimGziRG+sPxoa+/jJ8omUyLkpt/j/KT7a3XUtHE/Rn0/C66AOq0RmP+MbR86uZFPZpMpyCgnxLK6yQDHQ6433VuLysW6qP6apeuFeLUqq24WqVk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=i8lrNP79; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="i8lrNP79"
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 4FDE840E0194;
	Mon, 23 Mar 2026 12:19:58 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id NaYPOJYLWJ_q; Mon, 23 Mar 2026 12:19:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1774268395; bh=h5Pig0bs6yS0zZM7xSou5vIfSlafs5HDphDOZlyjE4E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=i8lrNP79sx6tBt9Kv2BrsgZ0C8jXdWqLEKlg/901RRGouDZPtaKe1WKUM09mBVIJM
	 uobp7Z3bv3FJsxzbT0X300d1ci+K5AEqbljy9CdeYktNq7wB3TAdJqyPVBlRk96QdU
	 axaueqg2AMDR+MeJSkQOtRoZgmwgXQlPllSpDOn1h3v1biBSSck8eNBKLPSX8RvZ8r
	 48j312cJznsqjRB1w8aEjjKp8jeLYlTYaDWKfyUM2sWggiySs8Ci+i8mfXbxLBUCpA
	 YMfAqj9xqiKSorM6j4LkHhr6wJvAoJWAOrj0Vk8L1tI8Sh9fuL+YsDOCPtDKdgn7Yc
	 eW4kv6RIl5rV0pm7zaI76kxfSrCGVRY0jZtp8nohR41KSzGzlDamcpj+fzrS3BbPej
	 xQ1a/8kBXWS8w0wqaV7dcDrzkhfZgJ52MyxSKQsQ2iasnOHLFSmdKFVCewE/qOz6vy
	 sU1wYmLBrxUiYCfUaNAzczyizMEfsNWRJ9f2RJqyO+TkUusfoaJe+z9uCW7xRYJYhW
	 zXLJ4sYpDqDVrfZlsCAXAGbQ/7ZSQ3eoQqSmLFybPobWJsViW/iYV7iwzCLH5Ytbyz
	 X3qKGzCqbwqQLJkl4RtJBfgyNS4rh4ZYXgtH3/BDNo6DnD3TK/TEPnICnnBFCSqrAt
	 UNWr9ocsViIRzOHJomhfllgE=
Received: from zn.tnic (p5de8e020.dip0.t-ipconnect.de [93.232.224.32])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with UTF8SMTPSA id F050340E0163;
	Mon, 23 Mar 2026 12:19:46 +0000 (UTC)
Date: Mon, 23 Mar 2026 13:19:44 +0100
From: Borislav Petkov <bp@alien8.de>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: "Kernel Mailing List, Linux" <linux-kernel@vger.kernel.org>,
	kvm <kvm@vger.kernel.org>, Jon Kohler <jon@nutanix.com>,
	Marcelo Tosatti <mtosatti@redhat.com>,
	Nikunj A Dadhania <nikunj@amd.com>, Amit Shah <amit.shah@amd.com>,
	Sean Christopherson <seanjc@google.com>
Subject: Re: [PATCH 18/22] KVM: SVM: add GMET bit definitions
Message-ID: <20260323121944.GBacEv4BjMMvTbjZGT@fat_crate.local>
References: <20260321000931.1947084-1-pbonzini@redhat.com>
 <20260321000931.1947084-19-pbonzini@redhat.com>
 <20260321115826.GCab6H4lNYIih_g0B0@fat_crate.local>
 <CABgObfbGxJYO0iXvkduFR=q=gyoF819pwkgJSke7SLr+6zCVZg@mail.gmail.com>
 <20260321154219.GEab68W-ln67dqTB5x@fat_crate.local>
 <CABgObfYHtUJtw4pykQ=cw3aJrc_KneG92GgG0dyaXhhKw4qHSQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CABgObfYHtUJtw4pykQ=cw3aJrc_KneG92GgG0dyaXhhKw4qHSQ@mail.gmail.com>

On Mon, Mar 23, 2026 at 08:53:32AM +0100, Paolo Bonzini wrote:
> The bullet that applies here is the second from the above list: 1)
> this series makes the feature available for userspace and guests to
> use it,

Also, if you're going to do this, then this has to be dependent on Kconfig and
be disabled when the kernel support for gmet is not build-enabled.

This explains the issue more:

https://lore.kernel.org/r/cover.1774008873.git.m.wieczorretman@pm.me

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
