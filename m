Received: from mail-oi1-f197.google.com (mail-oi1-f197.google.com [209.85.167.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 665B21F5834
	for <kvm@vger.kernel.org>; Tue, 11 Aug 2026 15:01:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786460467; cv=none; b=iJtwIHeTAYVsvef9UWC3AIwwMyz9DgRdaSZJfBVXoiTktX7Oy+L++r46tLFwWUJz+cYlTOEa2cCGmXWyX+eZD4FGy6ZA19SgvRkXNfc/uf03BRjI96JACK7XbyVwWuLNTeLlHRkRNOlLcjx67dJadehQ3OInZE+XDfgusSRElkM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786460467; c=relaxed/simple;
	bh=FX1+h96SOrDPrbnJM7Y3QDnLs6pnpuwF86BPYhDpA7U=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=aPcLv9ynYVtlYd3yvK5FAX4rDIjF6E6lqNB8T9+ZCrDWHWQ20MRFaCFrTgouWj39TQXdU9bl53hnsZJq2MpW4c6Z7apSjGNGo0J80z5p/3pkzHzIuo7+RvCqdyryg5WbASwsZUPo830d0YVvmIZD2crjhBOhhEjwyl9jW3mdCp4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.167.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oi1-f197.google.com with SMTP id 5614622812f47-4a46e8eec4bso529147b6e.1
        for <kvm@vger.kernel.org>; Tue, 11 Aug 2026 08:01:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786460463; x=1787065263;
        h=content-type:to:from:subject:message-id:in-reply-to:date
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=2euFBMzpkNGPQKLpYaZF3kHB1Ll/hUNRkhQD6KBsYmU=;
        b=seBjBaXgRQy1pSumHSo5XNiM9L/MeoU6QgUMirpsO+2jAYLYfvGDrIFaN7REifzFiM
         zCuXqae+NF1yaKNnkal79ra5CaTjWjKVEsJr4DEJDq9/Kz1hxZFsdRbA2TnR9lqUHo2D
         7X7pxi+/jgdr7xTiWCk7N/jVsX1s8HYIu90IKJv/eCmuY3asvljEIEEEGHeqOxqpWIVU
         5JgQJK3yE6bS2A2iDos+GiIxZ2rE9rPkiGsTklI/oEPe6IhFUFdalznwTbp9mwUHLjYC
         kaJaxTX/TuzxCtRinbe0DcHma+QwyMoch4nszMVi5PK7SB+qIxC6goGWTukT229Hj30f
         hIWg==
X-Forwarded-Encrypted: i=1; AHgh+Ro7LxxiLPkJljj3yUQgbfTs6Ui7rAJif9t4I3HgiPjK9JhhVtLdLewwqts/GvKlPBpllek=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx8b/2a3xWH7rCBDxNK7ONG5rdr6RHt7iHBG57S0LvxhVhq39sd
	O5noGMDIMXm8nft0bW8lxGaO7ETEFR8Jzy6i4L1xykqeJHleTY4PDlw956eb2Cz2OFzqOA3E0AF
	w7TyIo3YXH+d2w5plPk5CwFiVoFUuYu24KUOYZbUvKi81h9/nltYrm0s+PPU=
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6808:150c:b0:4af:741c:f60d with SMTP id
 5614622812f47-4b1fd8e604emr2429300b6e.13.1786460462971; Tue, 11 Aug 2026
 08:01:02 -0700 (PDT)
Date: Tue, 11 Aug 2026 08:01:02 -0700
In-Reply-To: <6829348563b5854a91ce91f724fe5181810239d3.camel@infradead.org>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6a7b392e.3668565d.e8814.0000.GAE@google.com>
Subject: Re: [syzbot] [kvm-x86?] [kvm?] WARNING: locking bug in kvm_xen_set_evtchn_fast
From: syzbot <syzbot+919877893c9d28162dc2@syzkaller.appspotmail.com>
To: dwmw2@infradead.org, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	pbonzini@redhat.com, seanjc@kernel.org, suryasaimadhu369@gmail.com, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+919877893c9d28162dc2@syzkaller.appspotmail.com
Tested-by: syzbot+919877893c9d28162dc2@syzkaller.appspotmail.com

Tested on:

commit:         bd0c3496 KVM: x86: Use gfn_to_pfn_cache for steal time..
git tree:       git://git.infradead.org/users/dwmw2/linux.git xen-srcu-fixed
console output: https://syzkaller.appspot.com/x/log.txt?x=17dd3132580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=9cef045500682f6b
dashboard link: https://syzkaller.appspot.com/bug?extid=919877893c9d28162dc2
compiler:       Debian clang version 22.1.8 (++20260613092233+e80beda6e255-1~exp1~20260613092250.77), Debian LLD 22.1.8

Note: no patches were applied.
Note: testing is done by a robot and is best-effort only.
