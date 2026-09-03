Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB8924EE86E
	for <kvm@vger.kernel.org>; Thu,  3 Sep 2026 16:41:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=170.10.129.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788453697; cv=pass; b=jHMsktTTKkNpe1AIpTjFlWdIOpu2BX/1P6DVm5EENXuW4jEd/nMWcZkc+wqZqHRZBn3SoBP6WcaIz1Fk8MPqtHfIODqAWRG1mDMsi6igxzkBBea5COHoP4hxFdhHrmWm4xzjQaCzpBSlrcIXWkhXL/pm3SInIM/zzcrTpnL0Jvc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788453697; c=relaxed/simple;
	bh=jmE5t/QWYXGduwCXTsexmNTSqycO4dgO83zrtscZu3s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qvXqelN802G2Zfo7fvoRiSrK1r2BAcULTI4oaOHk0XPNTtOtxdppvi52wv7V8cbkVlqtf6Tw67b/ZlPzQEQkLLmifNQToR/2t0VEeSYuQRnVOqu5s3OauS6u03lDb4Rrbx5hv1CrJWDNbxBaiRnMuzn8S0GWlSi6athL7a2ZPRs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=bFN9NjMB; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=ByO3dj2J; arc=pass smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bFN9NjMB";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="ByO3dj2J"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1788453694;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=96jSKrblNa/MGHlSRt22d1bqrg1HZKp/dYSrKcWfd2w=;
	b=bFN9NjMB1PGgROZP967lUpqy3JJf2a4AmMd4ONO5zYagyE2tW8LqlwAUNbApu20qbMSV2f
	j9lTNQw+G685Ct/Ud2hgJhgLS/M6hnFTgg+vX3xTCAi2+infDng6QbGEyjuyuPZPWpUCWz
	1VY7BgbOqa5DuyKc3geMZZWmQahgarM=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-183-EhO1sahlMUikmLEvSKj20g-1; Thu, 03 Sep 2026 12:41:33 -0400
X-MC-Unique: EhO1sahlMUikmLEvSKj20g-1
X-Mimecast-MFC-AGG-ID: EhO1sahlMUikmLEvSKj20g_1788453692
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-482e2541c30so6628f8f.1
        for <kvm@vger.kernel.org>; Thu, 03 Sep 2026 09:41:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788453692; cv=none;
        d=google.com; s=arc-20260327;
        b=ra07oV2S4MNCzxTKY0+1caze15CBwuFrzSSjMTmceAbSDfzkI2lW0fVBQBI8EzWjnO
         QP53av1i6iOxrM0gRVpMfbzGPtCs2aGMh0Z8PiIonf4xTOZM1RtYkqV7jA8c8iC72nVv
         asMid65OeTdiMRdhabYSilI2vPq/MKxNzHe2XnhhK5M4yx5KpBAVHzsxgsO2fepQW4in
         b7gDqOQKNAgN/iAlab1maxxJjB1RcJzdpL4dAT8zNk2SNQkn8QtmJk7lm4RDFwrBZv07
         ByHpqug7muap9yKow0Cl74dz1LOptxwGlbCoJg37/5MoCxp1tNWhazYYF6dCEAyDgTZC
         GQsg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=96jSKrblNa/MGHlSRt22d1bqrg1HZKp/dYSrKcWfd2w=;
        fh=QDAZK5hQYuDqxv20/fZV2L2R6QflhKZdemVqQp8lA58=;
        b=aBZD5Cii+pujbVp9v0KL2ZN+NrLbG7gSAlJEB4IvQUL4ElIeB/kI726pZWw65bR3ex
         OFun1CA20AZJZCS59a1xkTy7+5jPyBVPDc/8+Febl8HtAalJEKczBci92cyEzzZRrYD8
         4xMSN+/IDK64dACz6kd3sR0bXw/7nc7jGgYbQFNLxbE97DVYkekUPO70WfmwpNGxe1kh
         gT7WcJcOQjkLuI9koJm83C6b71XI2jBq2KLWi+qtwOw4czYKxpuJBqG0ZUDLLRuvLDgI
         rqPwq+s6i4ZFbbvGAahNvijgaLAqZG5NUpeAIjipVcaeW4tj2tPKo41USgfLfNHDny1H
         ZQzg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1788453692; x=1789058492; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=96jSKrblNa/MGHlSRt22d1bqrg1HZKp/dYSrKcWfd2w=;
        b=ByO3dj2JbfalBQKaZuQA0LvU+B5tRWZsqkyx1ctjv/yXklp5JqEcKRMof+z/H1ZFQX
         meWNtFb+OK4BLy/kIzzp3EVxnWzU7en1KdTQizQomRQHtySm9z3Up27vdVoGTtuYymZm
         EczFj1MGuI2vMOUbp0QmFIgj3opCOO6EJGRcVkJM/f/AsNaNUeQutHoO9iWxNazcbedy
         1/GF5jVQiy35qDbYezKO3ChOk1CnDTlFebWL29JvfZC3ktZ6znJBYOxdTPm/6Dj6RT9Q
         FaB4ieKp12fnhhTYvWV9vOvirsXoPqkoXVdtr35fA1OruqQY8svFt5ViIGK9SBypmaYT
         1OTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788453692; x=1789058492;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=96jSKrblNa/MGHlSRt22d1bqrg1HZKp/dYSrKcWfd2w=;
        b=qo0BVzwCAk6kAh+8pNkgBkRjZeOvEkeyOAZ6RbY8yGSUxFyJmZAp8+SCVnyG3pDi7m
         agija3Efmc87LrP2Ks+CVMbBTnHNadbE4K5sifVnhejW9G5oP4AEk0VS8TrADrZup7qz
         dBdmPdM21m4O0tI9NtXF4yfI+4cH71WoGdLZOFFmBUgTJFRrkVGZjBeO10FAqLHzFPCE
         Ermq6ke2hK97/b30BoS1Fna5D0/6V/vAkAreN7T5+TwZh1W7BN3QrHLPzNO9k9LSu2fc
         vSJNArpRbSLCRy9gIWzwnyD1Ob800y4mypD57H5psuTtVHzX4U2K7Wo6MjWqCL6oSl0z
         Emtw==
X-Forwarded-Encrypted: i=1; AKwUvBz0IqmQZcN5b80YEHiuuT0VzBC6ErOeK4oKPcr6TdxVAmJExNb9SARlQqSRi8807HZaoHE=@vger.kernel.org
X-Gm-Message-State: AFuF++kOViunvOywRW8tMW5qAr3CiMGGEmsN71pQ2LKrCTEoCuhqFJnD
	+fCsBaH/UkGcHX5AbXWeEblfu6i6p6DpBoj+XE8u8BdNdgZS1E+DmDKmB+J5lAOYXxx2CxtxGU6
	AFvamfFgdPiGuIKyKIVfhgOCoNjZ71SkoT2gXkvWi2dByemSB5yJkUnVeXuk9xEy9j/BsR3OaGK
	tB3Jqga7r+lRFi+O9El6jQEcnZ31/e
X-Gm-Gg: AYBFou3FON+IfC5H5JVqubDT9GeJbO1vzmZKv4J0DszbTwqXDn/W6l5fzodm5kTNTqN
	VsJ1Z+xsgX3EcftcZxTVwKgE9cvcvZK4sO8KCtC/v+eO0PlNiyqJgvSYS241DU5UNv+6ECEeRq/
	vIJ+cqFKTWbZwiMFHfpdyEQ6YQfjf3dkrEbBkvIxLJLxxdn2obEGqGrmwXCwUIPo7OiSRz1MOlX
	dJ3IOIIBYFQPaCbbQUN3KCc1g5SXEIITbLkhFG3kK4ZFA==
X-Received: by 2002:a05:6000:22c2:b0:484:3147:49c9 with SMTP id ffacd0b85a97d-48582315a47mr5571274f8f.2.1788453691981;
        Thu, 03 Sep 2026 09:41:31 -0700 (PDT)
X-Received: by 2002:a05:6000:22c2:b0:484:3147:49c9 with SMTP id
 ffacd0b85a97d-48582315a47mr5571189f8f.2.1788453691502; Thu, 03 Sep 2026
 09:41:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260831144802.834315-1-seiden@linux.ibm.com> <20260831144802.834315-24-seiden@linux.ibm.com>
 <aphMx5hsoXwIpNjt@google.com> <20260903083857.33034-B-seiden@linux.ibm.com>
 <apmHrnxRLl9BuVhn@google.com> <20260903154317.246414-A-seiden@linux.ibm.com> <apmhX8H-WUc3U4_N@google.com>
In-Reply-To: <apmhX8H-WUc3U4_N@google.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Thu, 3 Sep 2026 18:41:18 +0200
X-Gm-Features: AcwNN1UO9-vCqk6RvEI48oEKpR6Wrb2Fp2swzaiyckPlKKdzDRVW5sMiBpGtdhU
Message-ID: <CABgObfYUYCRtmJkh1Ns4VBbWqk3ggnDu294G9rZ6tva56=F11Q@mail.gmail.com>
Subject: Re: [PATCH v7 23/23] KVM: s390: arm64: Add KVM_S390_ARM64 Kconfig and Makefile
To: Sean Christopherson <seanjc@google.com>
Cc: Steffen Eiden <seiden@linux.ibm.com>, kvm <kvm@vger.kernel.org>, kvmarm@lists.linux.dev, 
	linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, 
	"Kernel Mailing List, Linux" <linux-kernel@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>, 
	Alexander Gordeev <agordeev@linux.ibm.com>, Andreas Grapentin <gra@linux.ibm.com>, 
	Arnd Bergmann <arnd@arndb.de>, Catalin Marinas <catalin.marinas@arm.com>, 
	Christian Borntraeger <borntraeger@linux.ibm.com>, Claudio Imbrenda <imbrenda@linux.ibm.com>, 
	David Hildenbrand <david@kernel.org>, Friedrich Welter <fritz@linux.ibm.com>, Fuad Tabba <tabba@google.com>, 
	Gautam Gala <ggala@linux.ibm.com>, Hariharan Mari <hari55@linux.ibm.com>, 
	Heiko Carstens <hca@linux.ibm.com>, Hendrik Brueckner <brueckner@linux.ibm.com>, 
	Ilya Leoshkevich <iii@linux.ibm.com>, Janosch Frank <frankja@linux.ibm.com>, 
	Joey Gouly <joey.gouly@arm.com>, Marc Zyngier <maz@kernel.org>, Nico Boehr <nrb@linux.ibm.com>, 
	Nina Schoetterl-Glausch <oss@nina.schoetterlglausch.eu>, Oliver Upton <oupton@kernel.org>, 
	Suzuki K Poulose <suzuki.poulose@arm.com>, Sven Schnelle <svens@linux.ibm.com>, 
	Ulrich Weigand <Ulrich.Weigand@de.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, 
	Will Deacon <will@kernel.org>, Zenghui Yu <yuzenghui@huawei.com>
Content-Type: text/plain; charset="UTF-8"

Il gio 3 set 2026, 18:33 Sean Christopherson <seanjc@google.com> ha scritto:
>
> How many people are running distro kernels on s390 hardware?  And how many distros
> actually change the default KVM settings, e.g. to build KVM as a module instead of
> baking it into the kernel?  My guess is "not many" and "almost none", i.e. the
> actual impact on downstream users is likely miniscule.

RHEL and SLES *are* distros, and I am not sure which bank or insurance
company would be running non-distro kernels. :) So I assume you mean
"how many people are running non-distro kernels on s390".

At least RHEL builds KVM as a module for s390x, but it's not a
problem. I agree with you that having the equivalent of INTEL/AMD, if
possible, is a desirable self-check.

Paolo

