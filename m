Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8076237AA9E
	for <kvm@vger.kernel.org>; Fri, 29 May 2026 17:22:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780075379; cv=none; b=AkiHfVstElEyd3KKK+yBZ+UveynDBbphia64xUPryrSQAY3RMbSQGGZQxPOBk+REB4+685xFFKhXedKtfKJUlGecx1nTBHIsZsmkw1KULDEYRmb8QIXSMG1FvUamVMrJjtGfFKbFQegbCacaddZUxrTrOFXCoqJ7sOzgEEh+YZc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780075379; c=relaxed/simple;
	bh=o5AGml7zoHuObhS6Wiz5FHPxp//wS7/Wm0oB4245/rs=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=b5Jj1S7cya54vQZOw0yokVGZ93SMhkamLeXlFzhWyccxEnD34pjTncVkXZD8k6z0LutnW8C3bZV+ifNK2TQ5l284Qqq18rfh5+kUHZ7+zJGISBRIFHtrn1UVnfvcY0zJzwAkCkLRBktwe5bszcfc0xA36Jq+kqm7FWtvsQOprzQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KC67//lx; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KC67//lx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 13BDA1F00893;
	Fri, 29 May 2026 17:22:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780075378;
	bh=OSM7DH8hFySxS00V3u2WkdfN2eEzk1arUB8aqIESUZc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=KC67//lxR27HWe1gnqzSv9jtMQA4g8isoFOCW5VEN/5mSGwN6gpIcqRJj4GvwvoaF
	 sMH+/izTK9YuuGAWO/2XZ7BRj4sJck9Y4A0qk6sQLLq6C7a4b4ReHZeBAT9y70VseU
	 6lBRxGb1xldn8bNcy/gsbFBiUtlkQA6Hq2fx+yY2hHAVWBa7irw74tQOKUun5NodWz
	 C4JcccS1DUmSiRCzPL9XsGNBCbznkHFEeMf7VgVUfOQmMzGQFJDiyHziUSarKK0lHY
	 kFqiJ7DNUN8l18YpVAZAdrFrVCoTKnGEShNfVHhomf6UKkWP+h4ji2kZcqe/m4NRRH
	 vnE6eEcDrd7zw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 05/27] arm64: Extract sysreg definitions
Reply-To: sashiko-reviews@lists.linux.dev
To: "Steffen Eiden" <seiden@linux.ibm.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260529155050.2902245-6-seiden@linux.ibm.com>
References: <20260529155050.2902245-6-seiden@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 29 May 2026 17:22:57 +0000
Message-Id: <20260529172258.13BDA1F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] Dropping `kernel-hwcap.h` from Kbuild's `targets` array causes i=
t to be unconditionally rebuilt on every make invocation, breaking incremen=
tal builds.
--

commit 56233effa49d4a8119244cffc6426b8b9f08a322
Author: Nina Schoetterl-Glausch <nsg@linux.ibm.com>

arm64: Extract sysreg definitions

This commit splits all definitions that can be used by non-native
architectures into a separate file sysreg-defs.h. The generated sysreg
definitions are placed into sysreg-defs-gen.h, and the tools Makefiles
are updated to accommodate this change.

> diff --git a/arch/arm64/tools/Makefile b/arch/arm64/tools/Makefile
> index a94b3d9caad64..4147187b66273 100644
> --- a/arch/arm64/tools/Makefile
> +++ b/arch/arm64/tools/Makefile
[ ... ]
> -kapisyshdr-y :=3D cpucap-defs.h kernel-hwcap.h sysreg-defs.h
> +include $(srctree)/arch/arm64/tools/Makefile.sysreg
> =20
> +kapisyshdr-y :=3D cpucap-defs.h kernel-hwcap.h
>  kapi-hdrs-y :=3D $(addprefix $(kapi)/, $(kapisyshdr-y))
> =20
> -targets +=3D $(addprefix ../../../, $(kapi-hdrs-y))
> +targets +=3D $(addprefix ../../../, $(kapi)/cpucap-defs.h)

[Severity: Medium]
Does removing kernel-hwcap.h from the targets array break incremental build=
s?

Kbuild's if_changed macro requires all generated targets to be listed in the
targets variable so that their corresponding .cmd files are included to tra=
ck
command lines and prerequisites.

Without this, won't Kbuild assume the target must be rebuilt every time,
updating the timestamp of kernel-hwcap.h on every build and triggering
unnecessary recompilation of all files that depend on it?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260529155050.2902=
245-1-seiden@linux.ibm.com?part=3D5
