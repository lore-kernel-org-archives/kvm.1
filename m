Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBE0E4A5EC3
	for <kvm@vger.kernel.org>; Wed,  2 Sep 2026 15:45:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788363944; cv=none; b=nXuIuMPQz68t3rjzmGMUskSGZB5SNqTR4YA26vZQB2qVpQJVzyob2jvWDQRXFsYKVldlHy9KcIry0vL6FdPXFHlQtAu8JvihvtlovBMB/fnhOGfEjghrVVNUVHrSvCTI+J66oCHzRM2lisLlwYLU2Iz+r+rdrpGifAFKzumT+vI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788363944; c=relaxed/simple;
	bh=i6d2blMPh9mOd0MVDNHjtlQcI4G4pg6dNuQH9dy935s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=asK9pQjI7os1xtH+18BNkNPej0NzSHt5ta8P5AWSberUS5k3jr5ZwwQuFQXtmBfJhWtrlq0Rt5mqofCB4QteXhQN7Wh9QwedI9ZSdu+o5SZPiC/kHW81irmkxm3yjlkDcLAGMCCXtbI6bDsBN+J01iYywBsX1ZeCA5s1eS5jlag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=kxcHVLnw; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="kxcHVLnw"
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2d9201076b3so15273305ad.0
        for <kvm@vger.kernel.org>; Wed, 02 Sep 2026 08:45:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1788363942; x=1788968742; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=TPysDsGnpI9b+EwUBvoDR+Wcd16jrG2t2FBfRR3MC1c=;
        b=kxcHVLnwWR44jc2KWneJ1yxy9PHuAJ3DQ9Yhv5pPbNgeIKj6rO06lfZum3OLb4OMDB
         T6rrlWFOPgo9Y89R+NI1q4lIdiaKx5Tp11+IT/R0EPeCAIw8AkmhiUK4PhhFSidXOFAj
         WgFDAU8m8YnpboKvusFP3BLFt0A9v/4VEARHGF9RT19svS12VqNeBwG/OAZcVe3SuF/0
         zAnm1i3TvyyUVWJcb0Uakbgt8jJFwjmC0Izj4937dR06zBkoRm342j2nuwKLoS3Sy+DY
         b4pVMn1kzcwhun33aHnI0/NYgkl1Nz6w7JJEeCPj3lLss2ESE5DqQyXrqoX2Td24R0/4
         yi8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788363942; x=1788968742;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=TPysDsGnpI9b+EwUBvoDR+Wcd16jrG2t2FBfRR3MC1c=;
        b=hUvn2m4GCQW+3W9g77gW7zWRy0fbl4kbm8fiZ9prkxFPjywl4mDD9BJY1e7nihc/+f
         igQCZou/ruIM9tM1VDUWNv53K5jmgnjS2Gcs4sN52gJK7/ggrunP0Tmex5C1c/QJ6xGV
         3yb6MXDGjZ+Nzhl+cRsTKf6XyKwjjCyZHwy1NBRo7+u6ECZRw1/c7C20iPTNjEYJkGOw
         sm4WBMY3tWYQyRL4A26S7C6yduTuP4ygiEzYPPIurOP8Pi9a+aSAx5+rq0j7rU83tEPL
         rxay0iRH1Bs6o9h1bSnes6OUuF4XCJDBfDuRv5oQN06GKDgxTGZcsECm3kCkw9BevavH
         AlIw==
X-Forwarded-Encrypted: i=1; AKwUvByRonog3M7JVPqc6SSgTr6rMqV4jjJxtQH3v02QC+vGyW/4XV4di0R+IhkhBACX94dOBX8=@vger.kernel.org
X-Gm-Message-State: AFuF++kAZuD/bVTZWKEXJotqEenkTwnrCZdjd8ulr3mGQ7mKNipnG/HH
	6CeGsTYeMIO3HvA1ruviI2eqR5O4Id7MKhW+YnkW77yKjdTcHYqQYz7LUeBQncgqCLo=
X-Gm-Gg: AYBFou2a/5Oxhr5ZiGP0ZqdUGZcmcx4DdPKAXkFZrSf/ji2+Akn+PFVyWglRkXG5E94
	AxMWZBLxU1LLrePQBgrTKlIFIDMEISLum2zauO4doZB+NsI0nmXt+mKCukl3nkmD088cndJp4HQ
	Qxwz9/iuZYgTWIFtQadqHPk+guVgTN2GVN2tDQy/qx8zN+BbAXdfxITJudyT1uBfVEYdI8+yhAn
	xlo82mKooARXuW6wwVnRx5xUpL53jZ/95H5piHdA8fznhsV5Ny1TL7ab1vWqbUEF3OvJEN5fVXc
	Aoo/Oqze7DyCisVcxf0VpRJDiVkt75fD8KjICgaE8o4YlWYnH3fPUVH2xTO+ywJ6Puby9aQdFeU
	Q1hP3Ke0a+heQPPsE6lCTZ5Rh8Ee+lVGOpJMPyJTLkUjKlDHMAz19z4nKvg7Ke6IosZRMqlAi2z
	jAr2YBtcr9x2XfZPfEMcax5vAFqiqnlNSQ9dzoZcAZfsISA54nYSdVIbUulYyYWdrSrDYcn5NhX
	3M=
X-Received: by 2002:a17:902:d4ce:b0:2d8:d2bd:a111 with SMTP id d9443c01a7336-2daec626dbdmr76719805ad.6.1788363942059;
        Wed, 02 Sep 2026 08:45:42 -0700 (PDT)
Received: from p14s ([2604:3d09:148c:c800:fff4:86c5:8d86:9e93])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2dadd48898fsm15694765ad.39.2026.09.02.08.45.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Sep 2026 08:45:41 -0700 (PDT)
Date: Wed, 2 Sep 2026 09:45:38 -0600
From: Mathieu Poirier <mathieu.poirier@linaro.org>
To: Markus Armbruster <armbru@redhat.com>
Cc: berrange@redhat.com, kchamart@redhat.com,
	pierrick.bouvier@oss.qualcomm.com, peter.maydell@linaro.org,
	mst@redhat.com, cohuck@redhat.com, pbonzini@redhat.com,
	eblake@redhat.com, lorenzo.pieralisi@linaro.org, gshan@redhat.com,
	enju.kohei@fujitsu.com, qemu-devel@nongnu.org, qemu-arm@nongnu.org,
	kvm@vger.kernel.org
Subject: Re: [RFC v3 00/24] Add Realm support to QEMU-VMM
Message-ID: <aphEopEnM1pEDLV4@p14s>
References: <20260825220101.3443954-1-mathieu.poirier@linaro.org>
 <87wlt55cs2.fsf@pond.sub.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87wlt55cs2.fsf@pond.sub.org>

On Tue, Sep 01, 2026 at 03:20:13PM +0200, Markus Armbruster wrote:
> Mathieu Poirier <mathieu.poirier@linaro.org> writes:
> 
> > This patchset provides minimal functionality to start a Realm VM
> > from an Arm RME capable host using the following command line:
> >
> > qemu-system-aarch64 \
> >  -M confidential-guest-support=rme0,memory-backend=ram0 \
> >  -object rme-guest,id=rme0,convert-in-place=on \
> >  -object memory-backend-guest-memfd,id=ram0,size=1G,share=on \
> >  -cpu host -M virt -enable-kvm -M gic-version=3,its=on -nodefaults ..
> >
> > It is a refactoring of Jean-Philippe Brucker's initial work dating from a while
> > back.  It is compatible with Steven Price's v16 revision [1] of his work adding
> > CCA support to KVM.
> >
> > This revision is based on Michael Roth's work on guest memfd in-place memory
> > conversion [2] and as such, the QEMU baseline is different from 'master'.  Other
> 
> Use
> 
>     Based-on: <20260528000416.8161-1-michael.roth@amd.com>
> 
> to document your base.  This stands out to humans, and is readable by
> machines.  Next time :)
> 
> > than modifications to use in-place memory conversion from Lorenzo Pieralisi that
> > were integrated to patches 04, 08-11, it is identical to V2.   
> >
> > It was tested on the QEMU SBSA machine.  For convenience, a repository is hosted
> > here [3],
> 
> Michael's series doesn't apply on master anymore, so I fetched this
> branch.  It's based on master as of *May*.  This won't do.  Please rebase.

This was clearly explained above.  The goal was to provide a patchset that can
be used for testing. I can attempt a rebase but can't guarantee a timeline or
success.

> 
> >           along with the TF-A [4] and RMM [5] for the SBSA machine (compatible
> > with Steven's v16 patchset).  The Repository for the kernel [6] is available
> > from Arm.
> >
> > Instructions to compile and run the entire stack can be found here [7].
> >
> > Device Assignment is not included.
> >
> > Thanks,
> > Mathieu
> >
> > [1]. https://lore.kernel.org/kvm/20260803134403.80630-1-steven.price@arm.com/
> > [2]. https://lore.kernel.org/kvm/20260528000416.8161-1-michael.roth@amd.com/
> > [3]. https://gitlab.com/Linaro/cca-public/qemu/-/tree/upstream-v3?ref_type=heads
> > [4]. https://gitlab.com/Linaro/cca-public/tf-a/trusted-firmware-a/-/tree/cca/v13?ref_type=heads
> > [5]. https://gitlab.com/Linaro/cca-public/rmm/-/tree/cca/v16?ref_type=heads
> > [6]. https://gitlab.arm.com/linux-arm/linux-cca/-/tree/cca-host/v16?ref_type=heads
> > [7]. https://gitlab.com/Linaro/cca-public/build-instructions
> >
> > RFC v2: https://lore.kernel.org/kvm/20260728192630.240375-1-mathieu.poirier@linaro.org/
> > RFC v1: https://lists.gnu.org/archive/html/qemu-devel/2026-07/msg02307.html
> 
> 
