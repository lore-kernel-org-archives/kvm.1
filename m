Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=91.218.175.161
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793894777;
	b=uxLk1tqSkyQYIZPdaZdP7xXrIHbVb/4/MykSGd1O6z4mDSwEjJQt8HzreT3kuW92tTJi
	 0n5Sz7psOaXCcRuNntJlFhc0q4HiYaKissGlrydHAyjYvPdG8Wh9c84bqwFvA6E7uQXxF
	 U6B1YcWWev01ppszb3oCchcagWOdLX9J+L9t71i3d2WzpTFUfP3ArmVLvhTerMkQNf+I9
	 SWgetfG+wzWTKGev1R0UMgokUbkka3zXuJbaP1iSUbcoKsN0lAVBfpYycDlT0AHkLjG1O
	 fMpCVbreqoH/s3VdPAKsJxH41MuFtQZ/Z8jANw21HkJQsG/5KG0+fq0U10Tdi2Cp9NA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793894777;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:Received:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:
	 Subject:To:Cc:Content-Type;
	bh=/cWlRZ8SCFwTMb55OqToMLGSlbLAYefJerAulPP2VEQ=;
	b=TfK7XO9HOeDAm72l5YTm08i97EU3TSLRnaXA2Uk+lUV8hchyFf7CEbrJ145jxpCCTM6g
	 Ge/gw8+enfjoGOnrFfPKWuH50nYb/UvTtj655yY4TJNQQ0zYOl/VZqQaoH05xrcI33sxH
	 vR47G+eE+ikJO1E5KT7aq0vribGj86DepeLswguZqhu3XOMv5gZ89BeqFC57HpG20xSjI
	 kDXCNxQTVu0QV7lPPlPb4RhmfFDvk6bA3Azhf4rTKJNF6FkswFJaikhW8KP4GtkJB0EaN
	 HPAxt01jtbBfd2xmX4Weplc4RfMvSgI1Duh73rVkzW15Ey+2q7b0Xec12Oz6N3QmE3Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=EMOrkC5s;
	arc=none smtp.remote-ip=91.218.175.161
Received: from mta0.migadu.com (out-161.mta0.migadu.com [91.218.175.161])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 088C0606A328
	for <kvm@vger.kernel.org>; Thu,  5 Nov 2026 16:06:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 088C0606A328
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=EMOrkC5s
X-Envelope-To: kvm@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=q1Jd3oCj3wElY/Ramn8yIWwh5Mzi3hHTvnQWrqt1nCM=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1793894772; v=1; x=1794499572;
 b=EMOrkC5sVVLJ80dqxga4EYGB2nalv7krTmw6OMvbStyhnJ9qhUSHYqMI6dK+DedLAdO6evv0
 DhxzHVDLbd4lE4DXlGrsxCEjmmS7O0s7Ug9/RltoYeBzEDKSAgpCqwU6JNurG45GXq6uThCRfRh
 GZnC5lLmKzLYlWBm7xRUZhkY=
X-Envelope-To: kvm@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id c1bfe697b5c1862e;
	Thu, 05 Nov 2026 16:06:12 +0000
X-Mizu-Trace-ID: c1bfe697b5c1862e
X-Migadu-Flow: FLOW_OUT
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-5bff701efa5so8060e87.0
        for <kvm@vger.kernel.org>; Thu, 05 Nov 2026 08:06:10 -0800 (PST)
X-Forwarded-Encrypted: i=1; AKwUvBwn1goJxe/r8ilZMCBrdSOGraVNxYTNNCUSb0paPCXiRE0WY1vGUIfSs4of3tNNctEQ6E4=@vger.kernel.org
X-Gm-Message-State: APuU4Z8Emn7KgMvuBAKoMJ6zvUh5QLRKfpWappl8A15GPH4+ePukvZT+
	tA9kXMb/hKWYoe9jLa+0rDgEEnTU8NN0WTjUF0qhOU4dCne7BRCz4OxSaROrYxs2wUjreZin+Vd
	OHI23WrRnHIo80nFGBajrXgPKRnPLzSiLzXvzof4l
X-Received: by 2002:a05:6512:6ce:b0:5bf:bec9:aaed with SMTP id
 2adb3069b0e04-5bffabc3e5emr166519e87.8.1793894769045; Thu, 05 Nov 2026
 08:06:09 -0800 (PST)
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261105110050.1244525-1-fuad.tabba@linux.dev> <861p8z2s5w.wl-maz@kernel.org>
In-Reply-To: <861p8z2s5w.wl-maz@kernel.org>
From: Fuad Tabba <fuad.tabba@linux.dev>
Date: Thu, 5 Nov 2026 16:05:32 +0000
X-Gmail-Original-Message-ID: <CA+EHjTyEOfDf4ynYuGz1ejE3s6R2syP4=zZMcq1oKAqFfDxCNA@mail.gmail.com>
X-Gm-Features: AclHuK9sqVJFjm0gw0BfO1w3RU0O4-fEP04HRvITK947bPe5QzS5BG9idCL7ftg
Message-ID: <CA+EHjTyEOfDf4ynYuGz1ejE3s6R2syP4=zZMcq1oKAqFfDxCNA@mail.gmail.com>
Subject: Re: [PATCH 0/3] KVM: arm64: vgic: Drop stale LPI pending state
To: Marc Zyngier <maz@kernel.org>
Cc: Oliver Upton <oupton@kernel.org>, kvmarm@lists.linux.dev, 
	linux-arm-kernel@lists.infradead.org, Joey Gouly <joey.gouly@arm.com>, 
	Suzuki K Poulose <suzuki.poulose@arm.com>, Zenghui Yu <yuzenghui@huawei.com>, 
	Steffen Eiden <seiden@linux.ibm.com>, Catalin Marinas <catalin.marinas@arm.com>, 
	Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Andre Przywara <andre.przywara@arm.com>, Eric Auger <eric.auger@redhat.com>, 
	Yuchao Zhang <ndaugoing@gmail.com>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Thu, 5 Nov 2026 at 15:51, Marc Zyngier <maz@kernel.org> wrote:
>
> On Thu, 05 Nov 2026 11:00:47 +0000,
> Fuad Tabba <fuad.tabba@linux.dev> wrote:
> >
> > Hi folks,
> >
> > The GIC just keeps on giving. Three follow-ups to my LPI fixes for
> > redistributors with LPIs disabled [1], to fix pre-existing bugs Sashiko
> > found.
>
> Can you *please* come up with a full series rather than this constant
> "here's another set of patches" that address the same thing, one
> pothole at a time?
>
> I'm now really tempted to drop all the patches I have queued on this
> so far, and wait for the "one true series".

Sorry about that. Every time I think I'm done with it, Sashiko pokes more holes!

I'll sit on this a bit more, make sure all the gaps are closed,
Sashiko it locally, before I respin.

Cheers,
/fuad

>
>         M.
>
> --
> Without deviation from the norm, progress is not possible.
