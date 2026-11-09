Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.49
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794203421;
	b=zasFx7jvyUkVabG4F3rObb4IG/9fskuWqLqexTdmETdgyC+hdAyHTN/solXrvBBOXbCa
	 z5++M6f0ZY5PUSOO4fw2zsfx0DHaWpudVHgLlnZj2IXKca9e2ssbhwK7sA7hFgwle8NFi
	 dFbDjCFLPl0zHKRUERyr9TMqxRx4qUekJovFDx3iYKq3iZqjzNyYmGPxnvT66yhIxbGqE
	 9LSt2YExbBJizWXC9jWkDGHGcviwjny5rMUFMDvVVtHN8zYU3t6cGTqTLhzF+yeinwtT1
	 2TiPNnFfyGR2lx7gYW1+LekdwpoaVKbmDxc57JCKH2suc8Ij0lAUYYLPOwhOxVXl6gQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794203421;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=zOU+uPjXYv6C9BQX655dlLqEf/JlKkzYX0WVqRX6Ues=;
	b=EHrTdmYuCOa6+1Kptks0DaRWpNw0j4Wf5kGEe/FXyGYEsZ5RiFGo/L7xlIyTqOTa7Wb7
	 iXKZ/llj4sQanmNBFDJ4FqkyDmPmvZKS5CeR+DUw2eIZG2wvMW1c/QCXK3avocdrvidnH
	 vfdkhVRYG+ndMxx44H3II3Jnuh/b0fE6Z8dcIGnLQ4ykbnB4CHOt/I4yQNfw3lGWeAggi
	 GTPGe8MO1CEmdI6vZwy4Pv9fh3SdT/raTw0nsNW2bTE8fZisaTy5265E5rRb9cVvRDXVV
	 Bcp3RPyNKTKquwoT3rvRz9z6wotepG5sjVrrCPOocclKPlgWHRKOBUoCQKhkaBk93xg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=H+JNnCsV;
	arc=none smtp.remote-ip=209.85.221.49
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77D31606A31C
	for <kvm@vger.kernel.org>; Mon,  9 Nov 2026 05:50:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 77D31606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=H+JNnCsV
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-492fcbfaa88so299462f8f.3
        for <kvm@vger.kernel.org>; Sun, 08 Nov 2026 21:50:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794203420; x=1794808220; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=zOU+uPjXYv6C9BQX655dlLqEf/JlKkzYX0WVqRX6Ues=;
        b=H+JNnCsVUCgEZDoYDAfHPe7mNmuUmXaMkyL2Meu2CESJ3eF/9IkHeMSJ5HmktqlVN4
         n3KRuKvVmC6z+woxboJ9o7gIInrAYyhtmje2bHrLupmfpGViEjZuBcKKvrQZb4KycvgW
         I59LI679DZHMSG3BNeHitkyEAqjCdUhhrK/FuJr2lHZwigU8/u5i7BEylOEuOC5mSYAy
         AK9unokS5+oM+Td37rkq1ARnkUhE2qxqiD7CEce0Ms25ARC/Ori1wMfT8mYKm41dk8e9
         bWcPaAlUaoRr6iiSlW3LAoDbVBYu9kOrU6cOxHwKFdad14q57OGh93Fc1w+vrX+WC1zf
         MHSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794203420; x=1794808220;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=zOU+uPjXYv6C9BQX655dlLqEf/JlKkzYX0WVqRX6Ues=;
        b=fUto7k2KwAdi6s2faLhyx7qDLzR8XYkpOdErYatcCNYfFFGL3fWmKaFL+mTPsL734m
         nWkyV5vGMNvL59KcksP+OztxP+zh6MtVtHT6Xw/WySq+BNUpE5HNOBRKFoF7M48yhj48
         6LLfWGbrzZCbb/lLwUgeDv1sSYcSqdfWcPdFzdsM22Dr1Ym5jAurTeVSQ+I+o+MUuZZw
         k4TU6f9ZOpBYPQSTqwj2WQ1k9NqCp7nfQcrr30p9L9FIoiSqkpTZjCogbJ5Tz7EDuaVo
         hVhzptrRi5vTx9awhe1mf+XHilAkXAkNb4rv5ZmINibgM5HmMk5cr8ZVe9KkW2MRnnet
         ZfrA==
X-Forwarded-Encrypted: i=1; AL+hErEGyp/5ka85tTQcW/iLNmhFQwPfKlev5bfBwpTxMjZ4JIdvyRwK9OKTbQtIbDcuen/NMyg=@vger.kernel.org
X-Gm-Message-State: APuU4Z90MT/D3sZkVSfluRMpyRAdtWLFfaPnfx4I1rOaiYEZFAWD3u4/
	eJh/7Zzqd9DkrKK3V4ImvL0GbXAfs4plj7luCmavhdkEgN+qIHCUS3dD
X-Gm-Gg: AYBFou3QMx+3a0RQv722+j8tptEAi49XAxe3VrHqMThhAhtCFPwWiHAXP2nBfpKG3eT
	y4FfnluUn6EXiVfckmrHGotrzI8u7hJTIBMnD9ZqLyYbq+yzwTC/PnRQqh5v1kWhMR3z1MrBIV2
	PdVcdwIJDMP4jxDCmOQ5FYAaWUzcc+VNfBJA7BIHlsbPim451uD9rxMaA4vehOp60q65+oJ5KVL
	6gPkK2oqWhdTX27DpbYXbDDntY6MzvVcMjDMqnzr4iCZm8aNpEgPIOoH0yARu/+VKbWS3ki7xSs
	vraqzuy4qeRfgKMWDUyeAANic3WIbVnO10t+0dm9KcPzhldu3VNOyx5DxqqbDfnUeY7ed0oxDNZ
	9ac7K3S/4rNG2h6d2WUMzKT5Iuwx21yFmM2flV2Ia5RCpZnH1m2XOFXAivVyXBLneLvrI6mSs4p
	vui+kb7ffB97VjGW60QFdvFkDCOEfsR9quPf3ZuQwazyLflFeu4WjF78Hwew2siTZe8/Hfu9Oez
	+Z951+i2MhNcnDiEUqPi8Y53u6cLrkfkaW+q4ndpAOslZVpIH0KyXcNUyv8r8+CVI1VX6tvLzQ4
	yBu9fCrZaUbQclWPGFDdSE4N3tnOKfG/+gv1FpcPPK8BVKBGH2/0ikB+eNKQhMy2yXUrfV4ErCS
	uO2IRlI5z1yzoIb2XBZ7K02w2raZlpUALCZUoyHRsYEfnfhIWR5UkJ3se+oYOj5NDCw==
X-Received: by 2002:a05:6000:41f0:b0:492:c04f:1dfa with SMTP id ffacd0b85a97d-49582badc4dmr5288099f8f.9.1794203419718;
        Sun, 08 Nov 2026 21:50:19 -0800 (PST)
Received: from localhost ([2c0f:3d00:6be:8900:ce5e:9212:ea4b:f30])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4959783e39esm7566761f8f.45.2026.11.08.21.50.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Nov 2026 21:50:18 -0800 (PST)
Date: Mon, 9 Nov 2026 08:50:14 +0300
From: Dan Carpenter <error27@gmail.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Sean Christopherson <seanjc@google.com>,
	Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>, kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org, Karthik Bhargavan <karthik@pereq.eu>,
	=?iso-8859-1?Q?Cl=E9ment?= Blaudeau <clement@cryspen.com>
Subject: Re: [PATCH] KVM: nVMX: Prevent potential user space corruption
Message-ID: <avFfFqotCajjCzTf@stanley.mountain>
References: <dab486f129c36ba1cfb322ceb56ec6fdef020ca3.1793959700.git.dan@cryspen.com>
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <dab486f129c36ba1cfb322ceb56ec6fdef020ca3.1793959700.git.dan@cryspen.com>

Oops.  I sent this from the wrong mailbox so the From: header doesn't
match.  I'll resend.

regards,
dan carpenter

