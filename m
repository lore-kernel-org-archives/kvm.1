Received: from mta0.migadu.com (out-221.mta0.migadu.com [91.218.175.221])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 005AF1A680B
	for <kvm@vger.kernel.org>; Thu, 15 Oct 2026 13:15:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.221
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792070159; cv=none; b=Ckn/SWyIwSNznU64FNpM4yQOXxd1FeHRaRFQ3ZSknOVGhkDtEVtRybilykIU8STf9Fe9okjK0cAFyo4zRuw5inbm687kf2GZ3UCVVFroBGVMjKa6VZu7CexbTO5/7kd6UJiLRoApX2IWjQiSkRGiV3kbkYqdU8fOICcb2Ij+cR4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792070159; c=relaxed/simple;
	bh=cBClqqcoRnjq1tJUyrLKGJx+LO26OjFSc7Ag8ZACa0Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EBVe2BsNpEDbHAVTziPerCJYhSYAnirgVAy3m4jc+vX+IJaYnlMF78TZtevJ6pt3B89uxn7wxAqpJVG0Y60aczYr0KKdaY3FjKt7m+6g4F4FR/8OL89W+McLacePPiql5AIQZG21mOcqc5bxv8/5Qcl3XiHdInoROdywZIKR3ng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=FFgACMSV; arc=none smtp.client-ip=91.218.175.221
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="FFgACMSV"
X-Envelope-To: kvm@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=cBClqqcoRnjq1tJUyrLKGJx+LO26OjFSc7Ag8ZACa0Y=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1792070155; v=1; x=1792674955;
 b=FFgACMSVjGrbSEPR2dLUmi3WDsf7CE9FvksqCyWv/lb3bymzAjdGyANWk2ztx+jVxmNhx0yG
 adBRHbMqF70GtsOuLpJtDdOXZ4d0xIXsW+gx6YB+TXa3Wp5jLAF5Vx4yyrmMJrqowhAUQ4bEk0C
 vNSJX/BcQyFJxPBpUJnAV8bI=
X-Envelope-To: kvm@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 07249f13e37a95ca;
	Thu, 15 Oct 2026 13:15:55 +0000
X-Mizu-Trace-ID: 07249f13e37a95ca
X-Migadu-Flow: FLOW_OUT
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-5ba429b64c5so4211e87.1
        for <kvm@vger.kernel.org>; Thu, 15 Oct 2026 06:15:55 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBwqbLISaD92kpO9jKs0rjZ4FZ300HSlwidb5z3F592z+3uq+3urKbZgQsJ02JGUplDmlNI=@vger.kernel.org
X-Gm-Message-State: AFq9FYIXQ840IcIZOduz3TGjDtUk/VaJnHda5WYssumuRjma6YUFze3+
	ERqTWnMltNrmKBMhDNjmw04SJ4ZK3jahfVL54s8l1RB2wsid3JyUMQUemmJ/9gar4L7SKBFjnJm
	MLHklZYIGC1dOM5x2pnBQ7ZPiGye3w/eC6tI4Wv3W
X-Received: by 2002:a05:6512:2211:b0:5bc:ce5b:96f3 with SMTP id
 2adb3069b0e04-5be3e11d7c9mr81883e87.4.1792070154180; Thu, 15 Oct 2026
 06:15:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261015100539.1011760-6-maz@kernel.org> <20261015125716.2650737-1-fuad.tabba@linux.dev>
 <86ld7z150j.wl-maz@kernel.org>
In-Reply-To: <86ld7z150j.wl-maz@kernel.org>
From: Fuad Tabba <fuad.tabba@linux.dev>
Date: Thu, 15 Oct 2026 14:15:17 +0100
X-Gmail-Original-Message-ID: <CA+EHjTw=CsL7XdMdV2g41ThRMQe1_Vh=HL5E50pOBT3ZWQ=PtQ@mail.gmail.com>
X-Gm-Features: AclHuK81C1k155nk4IeQL38Uum0spopA4W4U08O1g0zocLSDFFuwHaItMqtONv8
Message-ID: <CA+EHjTw=CsL7XdMdV2g41ThRMQe1_Vh=HL5E50pOBT3ZWQ=PtQ@mail.gmail.com>
Subject: Re: [PATCH 5/7] KVM: arm64: Add helpers to halt a vCPU
To: Marc Zyngier <maz@kernel.org>
Cc: Oliver Upton <oupton@kernel.org>, Joey Gouly <joey.gouly@arm.com>, 
	Suzuki K Poulose <suzuki.poulose@arm.com>, Zenghui Yu <yuzenghui@huawei.com>, 
	Steffen Eiden <seiden@linux.ibm.com>, kvmarm@lists.linux.dev, 
	linux-arm-kernel@lists.infradead.org, kvm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Thu, 15 Oct 2026 at 14:13, Marc Zyngier <maz@kernel.org> wrote:
>
> On Thu, 15 Oct 2026 13:57:16 +0100,
> Fuad Tabba <fuad.tabba@linux.dev> wrote:
> >
> > Hi Marc,
> >
> > On Thu, 15 Oct 2026 11:05:37 +0100, Oliver Upton <oupton@kernel.org> wrote:
> > [...]
> > > Signed-off-by: Oliver Upton <oupton@kernel.org>
> > > Link: https://patch.msgid.link/20260929212925.31775-2-oupton@kernel.org
> > > Signed-off-by: Marc Zyngier <maz@kernel.org>
> >
> > Should this one have a Cc: stable too? Patch 6 is tagged for stable and
> > calls kvm_pause_vcpu() and kvm_resume_vcpu(), so it won't build in
> > stable without this patch.
>
> My take is that there is no need to backport this patch at all. A
> valid backport of patch #6 should simply halt the full VM, not just a
> single vcpu.

Makes sense, so this will be resolved on the backport itself.

/fuad

> Thanks,
>
>         M.
>
> --
> Without deviation from the norm, progress is not possible.
