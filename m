Received: from mail-wm2-f12.google.com (mail-wm2-f12.google.com [74.125.225.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9ABEE3AFD0E
	for <kvm@vger.kernel.org>; Tue, 29 Sep 2026 08:15:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790669711; cv=none; b=nKweV2WlYPZSOKb/8/P97T3UJH4Y9HB6EMt3WVON3pacAjTBvf1dqx8jxf/bS19vVWntKQ5OE0VQkhMtgPB7fJkR//+VaZic2ffsd+sxGLtBG7Wh9ofWwimUu6t2P/bG0cxIrixASWp+M1nu8Zb8ueMz1NYteN+5xHFJ0c48MYI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790669711; c=relaxed/simple;
	bh=nqRGNPkOJSPCRNGCqHrDgAqHCM5yXfU5zF6swmIYNH4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bC1CVX1FVFEUl3UkRMQKH8udpX7vDNfFb2QcbL7ZRYaZpcEhXXpd79Lp77tOjZk5urYq6yABY6KvyYwmCCMxHKiNxOC3is/X6xPa5jDswnpfw3soVIoqdzeEpIY82wtk25bgo/nzVbemlenU18Pr2AkPySl4cAhbBxAObFKBGqw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HR+hCNCa; arc=none smtp.client-ip=74.125.225.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HR+hCNCa"
Received: by mail-wm2-f12.google.com with SMTP id 5b1f17b1804b1-49b912df756so30523005e9.3
        for <kvm@vger.kernel.org>; Tue, 29 Sep 2026 01:15:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790669707; x=1791274507; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=2XjctQkCqSCfpDqQlG2z1p9aO81GXpVDzes0Kw5Yea0=;
        b=HR+hCNCaHhcj+IwVcvT2tA1zM6gjVHMeZndeohKxOFWRJnjpORwfOC1tOH2XFEPDga
         ikkos7/UT4V9GebvVoqeyayYT1J3erAFGUTET9XwoK6i/Tl6bOfEjX90YrcOLrdOjnP1
         Iauisaan23B49EYDNLzdPgz5eXGF8sl9Gku/dVXXnxtFz3APCMOLGYJJ9b07nlg/8/39
         pYQ7WVdVpHW51tOddEfl7pq7EOOd5b+AIjimw/2O2OIIo8+LxBIvGvyNzR5Ksvbptxok
         S4wT328CrDHIZFG+5t4M/vrgv6Zc37SHDyQDM2Y08d5uATQUKcRsHMBjiB3WKWamvH1S
         Smyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790669707; x=1791274507;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=2XjctQkCqSCfpDqQlG2z1p9aO81GXpVDzes0Kw5Yea0=;
        b=hAReMLHqc8LZiUPcqiTQOHqgJuKUVXdSlNwflVy5x5uvPSb7FTL84gfMIPLPMIL1Wb
         NrdR6Dn0qMuXC8vsz5Ay7UtDQC2e55ucYKbSgaSsZBhWJzaA29sgmGV6w2sW6Mw5ENjI
         6WURS1XL/QJQnDTCpnVbafNtHwzDDRDLVZLUxrAmQqY6LAwdUio8hUF2tXJQcIKI+JLV
         ha3chlUT7T5Pvy8tVoUL7FeeoBtyuveT3pcXnImqyws3o1Hkcza3aCU083MwIM51ZsvQ
         Rp2yNQp+7LEmx7//+yq6+84f9HkQC8InjPSFTUOgzNYtEmeR6rBqC0iUwIDWrt9v1Hle
         TIXQ==
X-Forwarded-Encrypted: i=1; AKwUvBzrIl4rxmsPU7ajAerfKowkd6vDWd81cNXX0/AW9EfY/y89TVfxVkWfdAAvqTJgMrP9gK8=@vger.kernel.org
X-Gm-Message-State: AFuF++mMkdH80JpO+fdmxcD+2vx58ToVXNXPjfrelkVlWukpSZ7dhsMo
	jz9vnLAhW4N8XsAMNG0JhtKdb3Fe4H7EGbgpxO1OHN6MG2VsYp248OdM
X-Gm-Gg: AYBFou3+V+KLp88Zw7N3v2kmfkmyyXtM/iuSxji6ilw5SjVrb2UvO4gFsmZQpNcQstW
	bYAHUF4rBT97YXBWIWbMPfLomuONPIa4Z0I8jtniJiJdyqWUAAu6n3zbyzJwsASRwJPgGdArFsO
	1Tro2kT8UhNuLMlCegSRA5rZ9pFklbbt5ui/rjxKdbeWWluN1UUud1sDztx1K2jqImpig1pzpfI
	0BSYWh9zjnfN41Qlwx8eCIev4W6AvKopSSz4MF7mc98xNSOufxmzfnM4N0U5vS/J8HTdr7JrkLg
	iOSarqB9Vnf4SBYvxxIjEwWyads+9x3wihl/vdiyLywUEj5g6ch6egzjYMVe9PJ1/vrhdOIzjXW
	YHdXwMg081ak6zPmYJhDVdJG0BHK3lxzdLtbwWBDHpAn2x8GPeWhQ/Q60G5MdHus2c9Raa8x7cG
	TMrIX4BTnNWJGutNI7bJYm12F+fLJsoXBYQzF7tJX8O5+hqwtl7aQAT2yxRhSVReQBCfrjAoaNd
	u59ni7ORhxPnoVYoWdWG9x8GbPQOlAoEew=
X-Received: by 2002:a05:600c:81c5:b0:4a0:4f6:3dc5 with SMTP id 5b1f17b1804b1-4a004f63f6bmr72984115e9.7.1790669707346;
        Tue, 29 Sep 2026 01:15:07 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a00c130538sm54658975e9.4.2026.09.29.01.15.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Sep 2026 01:15:07 -0700 (PDT)
Date: Tue, 29 Sep 2026 09:15:06 +0100
From: David Laight <david.laight.linux@gmail.com>
To: Sean Christopherson <seanjc@google.com>
Cc: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>, Vitaly Kuznetsov
 <vkuznets@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Thomas Gleixner
 <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov
 <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
 "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org, Peng Fan
 <peng.fan@nxp.com>, kvm@vger.kernel.org
Subject: Re: [PATCH] KVM: x86: use assign_bit() where applicable
Message-ID: <20260929091506.5472bc5c@pumpkin>
In-Reply-To: <arsNUfVv0NhKZ6zT@google.com>
References: <20260920022649.3145701-1-peng.fan@oss.nxp.com>
	<arsNUfVv0NhKZ6zT@google.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 28 Sep 2026 17:58:57 -0700
Sean Christopherson <seanjc@google.com> wrote:

> On Sun, Sep 20, 2026, Peng Fan (OSS) wrote:
> > From: Peng Fan <peng.fan@nxp.com>
> > 
> > Convert open-coded if/else with set_bit/clear_bit and their
> > non-atomic __set_bit/__clear_bit variants to the assign_bit/__assign_bit
> > API.  
> 
> ...
> 
> > Signed-off-by: Peng Fan <peng.fan@nxp.com>
> > ---
> >  arch/x86/kvm/hyperv.c  | 12 ++++--------
> >  arch/x86/kvm/svm/pmu.c |  6 ++----
> >  arch/x86/kvm/x86.c     | 11 +++--------
> >  3 files changed, 9 insertions(+), 20 deletions(-)
> > 
> > diff --git a/arch/x86/kvm/hyperv.c b/arch/x86/kvm/hyperv.c
> > index 8d2669d8ef34..c131d9a3c550 100644
> > --- a/arch/x86/kvm/hyperv.c
> > +++ b/arch/x86/kvm/hyperv.c
> > @@ -114,17 +114,13 @@ static void synic_update_vector(struct kvm_vcpu_hv_synic *synic,
> >  	if (vector < HV_SYNIC_FIRST_VALID_VECTOR)
> >  		return;
> >  
> > -	if (synic_has_vector_connected(synic, vector))
> > -		__set_bit(vector, synic->vec_bitmap);
> > -	else
> > -		__clear_bit(vector, synic->vec_bitmap);
> > +	__assign_bit(vector, synic->vec_bitmap,
> > +		     synic_has_vector_connected(synic, vector));
> >  
> >  	auto_eoi_old = !bitmap_empty(synic->auto_eoi_bitmap, 256);
> >  
> > -	if (synic_has_vector_auto_eoi(synic, vector))
> > -		__set_bit(vector, synic->auto_eoi_bitmap);
> > -	else
> > -		__clear_bit(vector, synic->auto_eoi_bitmap);
> > +	__assign_bit(vector, synic->auto_eoi_bitmap,
> > +		     synic_has_vector_auto_eoi(synic, vector));  
> 
> Am I the only one that finds the assign_bit() code signficantly harder to follow?
> Maybe it's just that I haven't seen assign_bit() much, but I've come back to this
> patch several times, and I've had the same reaction every time.  IMO, this is a
> solution looking for a problem.
> 

The same is pretty much true of __set_bit() and even BIT().
What is wrong with:
	if (synic_has_vector_auto_eoi(synic, vector))
		vector |= 1u << synic->auto_eoi_bitmap;
	else
		vector &= ~(1u << synic->auto_eoi_bitmap);
'Does what is sway on the tin'.

David

