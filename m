Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91A543955EC
	for <kvm@vger.kernel.org>; Wed, 24 Jun 2026 09:55:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782294929; cv=none; b=upXD5NsnaUl6BNEtSz7S/6t2HozQXTVCHf+jZvPFlsYGJhfhbLwsHi0ghFCEakE+0FVMFtyptayEAj+Sj0gjGmMyjJONRwVhzFojLr1yED1WUwoVii4HaXx/wMA/9YEPKQloRl/qF61IomlGdvff6ff1mw7cJbeVKs3TD1wWpxk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782294929; c=relaxed/simple;
	bh=cyh9GNwkSeiWX8VVWJet6cmrStrv1Y1BhHYKMAKCy08=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=inmwzv3tQmhKI1TOa6XW/89C8y26byWKxa5YJqF83dbRj6UIaYYjvZeOSH+t/zX4UdPm03TxQHB06pRO6YN26G3DpjgDIIkLD9vaTh28o11oqUwG3VeUMtrSxi6Z4fE4EPupgAfJqEtn5H4MQ4t8t383rAcSKVNpqMsO56xLFcQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=UzquyN4M; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=C22jdX6F; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UzquyN4M";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="C22jdX6F"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1782294927;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cyh9GNwkSeiWX8VVWJet6cmrStrv1Y1BhHYKMAKCy08=;
	b=UzquyN4MTBS+gyJoMqsP+Izpux9zVKxlGSLnJY4LnNyZfOlGz/tTgXuO00k6OFRegSd3zc
	r6+lrgKrro+uZg/YVo6tYyIB9jXP5T7fIK05eIzm8Z/ES6dviFmfOG9Mr5uM2LkUSoMHaG
	uiYMpXqxz8FH4IFTkwBkjAvl9Z+GYXI=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-319-wCf6v-0CNLKvT-PdYqwDuw-1; Wed, 24 Jun 2026 05:55:26 -0400
X-MC-Unique: wCf6v-0CNLKvT-PdYqwDuw-1
X-Mimecast-MFC-AGG-ID: wCf6v-0CNLKvT-PdYqwDuw_1782294925
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-490b4d3d3e6so5982945e9.0
        for <kvm@vger.kernel.org>; Wed, 24 Jun 2026 02:55:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1782294925; x=1782899725; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cyh9GNwkSeiWX8VVWJet6cmrStrv1Y1BhHYKMAKCy08=;
        b=C22jdX6F/1Dml/8Fk7QI0ahPA3D0Q7VvEgGc2AKANDGfWoakSnQl4TRsTVQJbzdms7
         T7ykiisBLrm4h+zred8+2YrnIKasv31vZtu3R+wKRzIG5cbcattCLE5OMvvKaH69Vdrd
         T5URQ5fLC9uDIfjDqIKqNjGeMEOAN6j6nq+4uHJoupS+DxGSlvSzSSutiV+thdFUMz2m
         BqdqfV4QYvgE9wWhd2rCW+mFRK0g3elvNin+X/Krfvfo4qU0Z74rAOXocbEhLh6fGJUq
         /K86GEEj19rm0PGr6C8gGqFzCOF9oMVksoG6pRAwzjX92WLkDifsUO/YXHcOD6k4l+mi
         e5zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782294925; x=1782899725;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=cyh9GNwkSeiWX8VVWJet6cmrStrv1Y1BhHYKMAKCy08=;
        b=L9DRDqoK9HSutQIf/t2W0upDOlvCcvkLO6QHzIVVN2hxIlkPOL556U4Cdf7Ls856uE
         nCImDQ/OQt8+oyTOtYxSAxrc0sQi6IJn7xa7NtlPLJecPzORtez1dP6xrbjyZuEyBRGo
         P4g1r98vhJi1CN2FsLTgH5akLb836vuY937rjQzRgfQnqeOErCCS2fXkLoLixEYU6z4G
         EMIufZRwJn5FT4b20LSCC0EkAoVhJUXZS0Z0k3U0ZMQPn0oCq4CvgETzS8nx2IFGyE8N
         /9JjV9wU6HRVNd+XVejtiJZOmD1jsjGltYY0Bzki4y0jGJlYxyLhHB7wjWpxixsYzyHB
         1SyQ==
X-Gm-Message-State: AOJu0Yw48jOlVqfMspLWUY0ouapWofKLR2efum/F4JhS9eD03JZ54ZwT
	tq93TiqVjcWMP/mL3CcqyrdRECVMJIY+A2sf4/0UBecoYsoq9CFPYkmWTeWE6mb4Y/IsfjAwcc9
	DACSnzc/OW/VB2zbefV0uj3AOly3xfmufLtZhaDq8N5aWl2eS1LDjzQ==
X-Gm-Gg: AfdE7cl3E9aT5HBjZVFeRGkEJKXw4E+Z4zp7vixLGPPGKwn9+WU48U2sb8g+pUy+k1M
	tuQySTiV3kD/hHjmYSewoYZTx475CDpsLDDqV3qFFQTnl6lTKzbIeypMiV+H8/sdXuLmjKpKUKD
	f6zi7h/oDG+OTEBwzNjLGOX6awr302SVp8vjWtVpU6u9lCeK5mx/RCHLADSW5+AxAbcVBUlu/Md
	JKRuOgSJ1Ft5ewDabG5e9r/3e8/gOOcNlDnjSCCH+kUgtHpMT4kBNdCp4kD6ok448zjIbg/iaI1
	o6MeBgRCBvP/U3tDwsK5ywjpuhf/wZDGfdXrHYxbxeNUvQ8d9/dVDzEcvYtkHGK3RYNCgzJ9LEA
	h8r8ZEMkLYvAcba95+bfrYxKlQpgcAdwMJZoDdxnTUe9OZFdDql16NhDkeK1gs4RsbE7AXXy8oA
	gvwsjaBW04g9KHKJ7B
X-Received: by 2002:a05:600c:8a1b:20b0:492:2c87:3d4b with SMTP id 5b1f17b1804b1-4926211faacmr11334695e9.12.1782294925195;
        Wed, 24 Jun 2026 02:55:25 -0700 (PDT)
X-Received: by 2002:a05:600c:8a1b:20b0:492:2c87:3d4b with SMTP id 5b1f17b1804b1-4926211faacmr11334325e9.12.1782294924762;
        Wed, 24 Jun 2026 02:55:24 -0700 (PDT)
Received: from [192.168.10.48] ([151.95.156.160])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-492494496cdsm328410465e9.10.2026.06.24.02.55.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jun 2026 02:55:22 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: Sean Christopherson <seanjc@google.com>
Cc: kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	syzbot ci <syzbot+ci493c6d734b63e050@syzkaller.appspotmail.com>,
	Stefano Garzarella <sgarzare@redhat.com>,
	=?UTF-8?q?Carlos=20L=C3=B3pez?= <clopez@suse.de>
Subject: Re: [PATCH v3 0/2] KVM: x86: Fix VM-Entry fail due to stale CR8 intercept
Date: Wed, 24 Jun 2026 11:55:20 +0200
Message-ID: <20260624095520.980715-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260618174347.1981064-1-seanjc@google.com>
References: 
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Queued, thanks.

Paolo

