Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D9A83B3880
	for <kvm@vger.kernel.org>; Fri, 21 Aug 2026 19:09:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787339378; cv=none; b=dN1Z5z+g4mxoSXdGDDZU4+PhIuvzAU4/9kqNEXlbg+NDBA3EMa8qGfuUFFe53SaiPD3mi4t+VWQhZvvHcclShzMI7XR+6UE11QIm8L8ncB5EvWyIgJXcfabLgWOMOf9+kTsMsEprOCraZ72NN+wCSXvKkQlgoCiSt1Uw0uaBclY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787339378; c=relaxed/simple;
	bh=m4AbHNYOybKycCffk+1NRelRi+xxrvqfKKYJ+6qV4UY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=e9T8ydLmxuNqNy/lcArbzGty3foRvKhgDqviSzQP50QAWJUJiPXLVbmXIn5QA17NVFky/4Fs/OeL1saCiBEKHTByx1JLSOhJSbFobcDHdqiWjvkBIHxJJ+EOMGHtTVKMpnDD8AowHbEKhgvHWROiuHsPD2m6+dziI28Ss/6x0Kg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BJ6Z36jb; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BJ6Z36jb"
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-c15d47266baso162358766b.3
        for <kvm@vger.kernel.org>; Fri, 21 Aug 2026 12:09:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787339375; x=1787944175; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=m4AbHNYOybKycCffk+1NRelRi+xxrvqfKKYJ+6qV4UY=;
        b=BJ6Z36jbhziPKplfMzcvHV7AU56iF45AqbBsSpea8A7keRYxV5No/hpR9MIhModTvl
         czh0CB0pHUnn/hITfDLi0hpREthtEr+rd7joZnZbMvcvf5B+bS6OJPq1JJlyY4L6jXCY
         ifKWAtTcCeUlfKQHf6Q28G77DHY4x6uiAFzeF1sQM2c+m0bNlvyXYAOyK8Ycu7zHb7nz
         rsW76UkZFj1QSXCzHm6Dmvx4Pqq1yJ78eVeRuGtSrXv3u33eLMqCfrme+UDXkwngXcYc
         TmXoJAr5355T+vs+rspd/oDdWMcMAxsZQkeK+xGQCM+XOwzKyrhYg3WhEl75rJ8EesKN
         6KTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787339375; x=1787944175;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=m4AbHNYOybKycCffk+1NRelRi+xxrvqfKKYJ+6qV4UY=;
        b=lQcGTFWlu73foYvjotcY7EZuKppHDfpQZ2ZsyL5A3P6kgDIM+nOsZR2MtyCMDYk4gi
         IOLGdCEKtksXAgG4jf/CFGPSCNxppB6RhuX0aQAVwnWFszCSdLdzqQY6NR1mbuw3R93y
         BY8+2f2snyiEnBSRPx3909kEnwB/NYS+tv59l+khabl7E/qfLqUpb3v6OWiABHGOx+29
         F+sAaXjoezKsuHxr87SUKu0i797h8ZE6VfaUXYiQusv542d1yg6mMxXis3oxtHTXn+2u
         4ZqPatIgeeiZf4owGzNelmNWA6sjgFylbVYxhVaPR7ac+4MdmDyXCYY8DX1flRnekB47
         Wfaw==
X-Forwarded-Encrypted: i=1; AHgh+Rps8Wzc+67pyoqwIT+t39xjmHZHBu72AVrY8Nvs9KUns67dnxt7K1XIDv+sQV6xyeS+at4=@vger.kernel.org
X-Gm-Message-State: AFuF++kZKTCU7QlVeNTGlgJ215abfVqVwHFBH75AIyVhFDRpqxDnBAGA
	ImpoNYR8m6S+XmlyUu4Yyj5VH+zwiPJoh8Har/bFa5glScT3p8LJ9pgc
X-Gm-Gg: AR+sD11fSpoC/Psk9goCU/IR3GBwcvlDZr3A3Ff8JLrjP1uvdGBNGPsedA0pB3p2s2g
	W3D4ySU3ZwH3fJLctDpVPxLd3MgQlyQVACmNCNFl0a4mDsVOnk2oYRNV4K2iOH4AL96iS4dw86k
	9Z8XfUBTsKLeyJ518er2nLEtiRpwAophyS/kZ0RxKtvXAtzuC2p6gGtbHdxPO1mwNykz9iYT6kX
	Sl+jHZvVMk0v+AJnjCZbZ7lUcK4hiP1DEyy94ax4+1cO0mv5lTsOz1DDnJ3ry79aqRoISODNpmp
	yk2uQkTBNgJo1/mpLb4+Uqndoa4/HVS9ey57Q372FO8qMSTNoikbpXGd7/OFN9S7iPIA6AtJ0td
	B6ReE568jhL4R0z0pZMovo28mPwzgwUAjlmvIwXBUDJQuMT77ubT5YXtdKAoU4Jbhhopedjn928
	2zwSC7fvzkC8ZkO0sWp6uCmT3OqHpwF0GlkGNKzWh0nb20R+gRZqJcRE/hE1y2ovJrp6q9EChIm
	v34mjd6mTLZ9y1Wdq9A9dafpIiRH9EArArPNOpZHKR+I5fmdfQadIscyzBevRfjDseKpQ62N8tK
	PbzbkcrPcZB1STYPU3cONKm3VGJmMlJ5zdcPgSuTz6y+U2svoTDns7MyyTBRHXUbIJ8Upvp9vd2
	tSA==
X-Received: by 2002:a17:907:97d5:b0:c20:21be:ea75 with SMTP id a640c23a62f3a-c246a33ea8bmr796814866b.8.1787339375197;
        Fri, 21 Aug 2026 12:09:35 -0700 (PDT)
Received: from MBP-von-Karl.localdomain (dynamic-2a02-3100-a103-bf01-4ca5-89c5-9aa3-9754.310.pool.telefonica.de. [2a02:3100:a103:bf01:4ca5:89c5:9aa3:9754])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c24589e2ab2sm584196866b.7.2026.08.21.12.09.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Aug 2026 12:09:34 -0700 (PDT)
Date: Fri, 21 Aug 2026 21:09:32 +0200
From: Karl Mehltretter <kmehltretter@gmail.com>
To: Marc Zyngier <maz@kernel.org>
Cc: Oliver Upton <oupton@kernel.org>, kvmarm@lists.linux.dev, 
	Fuad Tabba <tabba@google.com>, Joey Gouly <joey.gouly@arm.com>, 
	Steffen Eiden <seiden@linux.ibm.com>, Suzuki K Poulose <suzuki.poulose@arm.com>, 
	Zenghui Yu <yuzenghui@huawei.com>, Catalin Marinas <catalin.marinas@arm.com>, 
	Will Deacon <will@kernel.org>, Paolo Bonzini <pbonzini@redhat.com>, 
	Shuah Khan <shuah@kernel.org>, Eric Auger <eric.auger@redhat.com>, 
	Christoffer Dall <christoffer.dall@arm.com>, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, kvm@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v2 3/5] KVM: arm64: vgic-v3: Unregister redistributors
 before freeing regions
Message-ID: <aoiiHw4hBHB7C5uL@gmail.com>
References: <20260819224229.82948-1-kmehltretter@gmail.com>
 <20260819224229.82948-4-kmehltretter@gmail.com>
 <874igpp3qm.wl-maz@kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <874igpp3qm.wl-maz@kernel.org>

On Thu, Aug 20, 2026 at 09:58:57AM +0100, Marc Zyngier wrote:
> The other bit of interest is in __kvm_vgic_vcpu_destroy(), and its
> conditional removal of the RD iodevs. Can't we just get rid of this
> whole block altogether now that we have a saner failing path?

I tested removing that block.
It reintroduces the use-after-free fixed by ae8f8b376102
(“KVM: arm64: Unregister redistributor for failed vCPU creation”).

Karl
