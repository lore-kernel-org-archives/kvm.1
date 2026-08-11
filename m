Received: from mail-oo1-f71.google.com (mail-oo1-f71.google.com [209.85.161.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BA4142A78B
	for <kvm@vger.kernel.org>; Tue, 11 Aug 2026 10:36:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786444587; cv=none; b=ip539HEPzYytsCieAHQWqKA4T9F1JN1wPj+VW2X95LvEBA1JlBg2I6X6Fh79fiHkhcC85kIO6GIBOGhdL4+R2h8yO86LHRl6A3PAwoko5ZUpce5d8/IbuHBQI85exviGlTAJtIGb3qxerM5Q5vxgbQydOYRmcYBC+8ac6L36zl0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786444587; c=relaxed/simple;
	bh=rXnqeVJzsCsv8oa0Z5I0vF68kADPeFRjAl2erJrVO9E=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:Cc:
	 Content-Type; b=nCEg9dFeDIsV3lyagaY+lM0Nc8PwGbS7vs2oVRv1ZPhspgowUjGoz9pSwxaHvs4C3VYgZqW3PajPY+s/8Ir7R3LUY1gkWzbp+d0Vw0xeIZyTubITjglyrmlqw4T7MCpd9Mq4Duk+jZKDMyU3hfG4fs7lCAqTdWtrBG84rpEqaNQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.161.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oo1-f71.google.com with SMTP id 006d021491bc7-6b026a31fcdso2147012eaf.1
        for <kvm@vger.kernel.org>; Tue, 11 Aug 2026 03:36:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786444585; x=1787049385;
        h=content-type:cc:to:from:subject:message-id:in-reply-to:date
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=rXnqeVJzsCsv8oa0Z5I0vF68kADPeFRjAl2erJrVO9E=;
        b=T5ulsiokyCf5aZ7syDAuPZ5m9ut4qITwrS8EIkRpNj2VlcEjwiN0mbwohupSF7LDxY
         MCXnWnIi8tNePS2tgzOvczyiiVEzfqXOAryJy4jc9CSJgyJN9K+++/HUdNLUxszVDkrR
         uSw7ZdYcuQP3DVC/A4vkqMurSrGZBzkI49bPgIcOxm49r1t7G2fknwTzijK2N+Kj7lEI
         aGa4srFlwc+plEJgANiU7Zi36Tfxlrl4oywv3RtAwWyaR1At4uPN21k8fjP1BODNX7mB
         l4jNkxuDRt5eaZgeMgA0OzB0Gnw0vM0gmXl/3uxw96lcL9wLnrKJ1HHZnPbByoD7qdwy
         j9bw==
X-Forwarded-Encrypted: i=1; AHgh+RoY5V5Xx9zBXBT270/5Oieb/9wloivoq5DKOU7TCjATcZtDQK0Y4UUAC8G+Uq7y6sdsclU=@vger.kernel.org
X-Gm-Message-State: AOJu0YypDps0MaFheV2S44yY9Q49SDoSBjJhj9mhT4j0D1PH1/ceBNip
	u9Z0KyIjYWo/mExdHn0llpVyfRTuBLBTqARyA0oCCLD6yVFT80/Big7hdoMn27JQDYCxn2yhiaZ
	KsUYS6GWpeTQECgscg7s1Zn2lEGc3v7qF3bVN+RHwqeXtx+w+goozDYhW+Uk=
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6820:617:b0:6ac:b6c0:2c09 with SMTP id
 006d021491bc7-6b0a2f6d78dmr1194145eaf.1.1786444585073; Tue, 11 Aug 2026
 03:36:25 -0700 (PDT)
Date: Tue, 11 Aug 2026 03:36:25 -0700
In-Reply-To: <8088767c672d154f7983ccfc5472e38b9cfc85f0.camel@infradead.org>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6a7afb29.9c11d2ce.289b96.0104.GAE@google.com>
Subject: Re: [syzbot] [kvm?] [kvm-x86?] BUG: sleeping function called from
 invalid context in kvm_xen_set_evtchn_fast
From: syzbot <syzbot+208f7f3e5f59c11aeb90@syzkaller.appspotmail.com>
To: dwmw2@infradead.org
Cc: dwmw2@infradead.org, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	pbonzini@redhat.com, seanjc@kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

> This should be fixed by the SRCU conversion of the gfn_to_pfn_cache
> locking, which removes the rwlock which was being taken in hardirq
> context. Please test the branch which contains it:
>
> #syz test: git://git.infradead.org/users/dwmw2/linux.git xen-srcu-fixed

This crash does not have a reproducer. I cannot test it.

