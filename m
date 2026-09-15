Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com [209.85.210.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 876E83655E6
	for <kvm@vger.kernel.org>; Tue, 15 Sep 2026 14:07:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789481235; cv=none; b=TA1U79P+2oXSIqrMbN3Vf3lxG1Io71BdgtjjsmRJWfQE/EXvJukEKu+Yx08+N1Ues+0J/NZHYpbm6DmLsOgqhcTyvQD4lDykbmpmuQ3Cdl9TEyqcFAsIHDEXiQqGqzyfAvuj8u2jsrIblNClRpM4WCuf+MwsldekKpPfSWx1KK8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789481235; c=relaxed/simple;
	bh=dUjR5VVk2wCNrZ1Ap0wm0ypuZi/AZCH+XXIJOu8WIFk=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=u0fp1NbuLtb40amNLcIMrf+VYFB6zn7UEK4bOYcfAflk4ece5MWrcHrje/M7yU+3H8pWRYhRUDF1yDkp71UoqpD8nlPEqb08vlWFbZoWTuyibpX0KVTBgdAlZSgNwu6Uts8lDzP2dWP2EfI6gWZxWTnwFm4VO1Tq5nSH71yF0fY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=vyMf3zQ4; arc=none smtp.client-ip=209.85.210.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vyMf3zQ4"
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-86a2639398cso7142821b3a.3
        for <kvm@vger.kernel.org>; Tue, 15 Sep 2026 07:07:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1789481234; x=1790086034; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ocV24YaOpEhXgOxf7ysBfgsFY4XTMXobXdtS4MklkkQ=;
        b=vyMf3zQ4UehxJIkAZCCjUQ2J2c0UL6WW039++4QLIGHup4MXkx5JXs4ZR5CZI90feB
         qc3oRx/pLj/OY+x0YYHB5WerMWCAqkyBVJd4C+NfqWVTS/Y2lM4vj1bf8gHf+sBH10i5
         dMIdEVVzf23iK2/kR7MqaIOoK6cm3D/qX05zLntYJiGKfsJ/c1/qkB6piJTAKjeLiXPR
         np220k8rYLZAm9IqmmVa+iYSfmL57dBD6MC4pyL9MvYKW1ukXxOVdq80p311V1wi+gb1
         E5zfuzmmTU28msQ9RNrrsscjI9FOe0FRoga3moNBOsTp5OXn9czJOpls/I4vj7uKY5Nr
         pbhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789481234; x=1790086034;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ocV24YaOpEhXgOxf7ysBfgsFY4XTMXobXdtS4MklkkQ=;
        b=hwXMHxKh2ImzcRKnC8jJK/scGScKU6Kz2u99zdiZMFvU6ORSGfGggl11P6J06z0CV1
         ox6oErBjCo/ayN9TiZJ1S0lTbmVMfk2vTu0qNjoeWRVkDaHs0Kp/k+gz8TprjHTblfrj
         X3KbvS885veSvSF0raiORFQMkLAIYzI5YFkRqWvU0f7bNccsIrE2kztSCTpmQVP19ANs
         JdJvSBpIs8maNE7HNdcGzGXoxI1i9TJrHclkQQQCor/qTAmy7BCqD8P4Sjdb2pUxvfGP
         v7Abnb+4Zsmcti5ttxSpWjIKo5XWqjUYCON+22G2rMlpeiceZOA4lvFIwuUvvrpk/qSE
         8cbQ==
X-Forwarded-Encrypted: i=1; AKwUvBwzWftSniFUJCHlQDkUUyhrZrUkw+g27UQ8pPk4z7DepfcyPa/dFc7I3HkPXR58i9plKTo=@vger.kernel.org
X-Gm-Message-State: AFuF++n5J7gWB4/80Jaos0ao4nNMXPEI5waZdzHOybBh5UPmww51Ebil
	Z5StouG6sCFoSOl3VRjZG0EemahsFA7p97TOB+auEuMVCGgXXH3Dx4nV/arTsnFb4fm+yURGkTY
	MXZf3MA==
X-Received: from pfch11.prod.google.com ([2002:a05:6a00:170b:b0:86a:72b7:1388])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:e86:b0:86d:117e:5dd0
 with SMTP id d2e1a72fcca58-86f83055846mr14705977b3a.5.1789481233641; Tue, 15
 Sep 2026 07:07:13 -0700 (PDT)
Date: Tue, 15 Sep 2026 07:07:13 -0700
In-Reply-To: <20260915092632.2822169-1-peter.fang@intel.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260915092632.2822169-1-peter.fang@intel.com>
Message-ID: <aqlRETiO58SWjFLF@google.com>
Subject: Re: [PATCH v4 0/4] tdx-guest: Make Quote buffer size dynamic
From: Sean Christopherson <seanjc@google.com>
To: Peter Fang <peter.fang@intel.com>
Cc: Dave Hansen <dave.hansen@linux.intel.com>, Kiryl Shutsemau <kas@kernel.org>, 
	Rick Edgecombe <rick.p.edgecombe@intel.com>, 
	Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>, 
	Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, x86@kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org, linux-coco@lists.linux.dev, 
	kvm@vger.kernel.org, Xiaoyao Li <xiaoyao.li@intel.com>, 
	Binbin Wu <binbin.wu@linux.intel.com>, Tony Lindgren <tony.lindgren@linux.intel.com>, 
	Artem Bityutskiy <artem.bityutskiy@intel.com>
Content-Type: text/plain; charset="us-ascii"

On Tue, Sep 15, 2026, Peter Fang wrote:
> Hi,
> 
> This is v4 of the series to make the TDX guest driver's Quote buffer
> size dynamic. The only functional change since v3 is an updated
> TDCS_QUOTE_MAX_SIZE encoding. The rest is documentation, changelogs, and
> stronger page alignment for the Quote buffer size. It also collected RB
> tags from several reviewers. Dave, Kiryl and Rick your review would be
> much appreciated.

Where is the breakdown of why "generating quotes entirely within the TDX-Module
is too complex" I was promised?
