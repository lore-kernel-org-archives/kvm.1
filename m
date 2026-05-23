Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EFA45B1EB
	for <kvm@vger.kernel.org>; Sat, 23 May 2026 08:05:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779523546; cv=none; b=bco8P6oAJA/5X52Z1Ton/pDJF9eH35MitIXeD+lpW3iupE4+hnFRUfSD1JuTA79nBRFAI27hL5XQjaL9hxKdtyc6tbDgZqOfBYSLHljmzqOHDccFizW7uD7PXjZFYgKgG/q3WhabVas2+PIfwAM9v/Jl5HydmZEb6XrRQmdxK2Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779523546; c=relaxed/simple;
	bh=cyh9GNwkSeiWX8VVWJet6cmrStrv1Y1BhHYKMAKCy08=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LQ8M4w+LLmiCYpxiXf/peYsTl5i5BtOqI1I9Yf3t1Qk9nzp4Wdkzz+hrgifsFOs9LQwAw8msbQ8Q7Fu4i1eSK74V04Hf1jzLjqWPJ+frBfKB8iE6z2SWeFrIejFHP32XWVYgKzjzj8c92CRegI0Fzb1XtlwwK7xRnEQgrEoPHqk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=cAi0Z1yz; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=iuFKCKXQ; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cAi0Z1yz";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="iuFKCKXQ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1779523544;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cyh9GNwkSeiWX8VVWJet6cmrStrv1Y1BhHYKMAKCy08=;
	b=cAi0Z1yzLXhDQAP6o8Qyut9ThhcXXM593qJ/byx1MMoACS6iILqskdPgcodrT75Otml6mv
	4bwKk3Z4/daOJX8RQDHk0lADbrVUXxaG41UN+ANPnDMijMBNKLcbCXcMD38UYMRXhhXLoK
	yoLZ0NcaVLdTJcGjQ4uEERBBmpOo9yo=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-580-tX-2mY_cOxugBiRONn67zg-1; Sat, 23 May 2026 04:05:42 -0400
X-MC-Unique: tX-2mY_cOxugBiRONn67zg-1
X-Mimecast-MFC-AGG-ID: tX-2mY_cOxugBiRONn67zg_1779523541
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-b92323d85efso173889166b.3
        for <kvm@vger.kernel.org>; Sat, 23 May 2026 01:05:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1779523541; x=1780128341; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cyh9GNwkSeiWX8VVWJet6cmrStrv1Y1BhHYKMAKCy08=;
        b=iuFKCKXQIJMGxcRkoR4rCrXaIqevkqf5au0Bw90ZmbQggC58BU0y8g8qtoE6gA3AUI
         esvSUsL3T0iQIWWawN++DqASPKLm/KNi3URLFEbyv6U0p3UqX2aYqIypn+UPjbTv2e5E
         xaLRQ7cZ37eAVIaCNaZ/9QTNEkh3Vo6CfW/6iTlHxbgEpVJ9R490dJ2evesGY2hYscmI
         NF72ATboAhBMyB50LAnIulYEnFitiF1cO8h7BaTA5oXjOtAK5jDcjnOggLajDHzOgDui
         dUMUSpwbsvtWZTJVxWZrrtFZtIP3IdDEoT5p66cA/Qe2E+yGkHKEiLt/wqms4r0mGFhO
         YnnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779523541; x=1780128341;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=cyh9GNwkSeiWX8VVWJet6cmrStrv1Y1BhHYKMAKCy08=;
        b=Vhtz0S2gHFGwhbpHNTPJehQ4sdkt0M3Ov+KivHLZo/2G82IUX1iW5hpoq2W+i/k8Uu
         j/fGyHM4Doc1YbJAb6tp/PagwZGdorm4JrH0kpDVanKu6lavO/tyuVg/5XPImO5qTm93
         Ixi/3Lt/E7gzsCjqwxP7p0R7XinMBjx5y+SzL9qGZL/8oQFMeKUEw80rbro9XPclADdx
         frH06cZHh3J/j46X8PhopPmm1iHcK1TLfiCahRXQ5+W36568En0rxM3NhqrTalQMS30K
         HW/VnyUxC08nJAqrtSzYxR+0xU+wKpIkgFtBs1GfcaLUR2tLFrzS3w2FJDJOPAQTETnI
         zUNg==
X-Forwarded-Encrypted: i=1; AFNElJ/5m0PtsMfZOsZYgsnvkgMQ7mcbj5zAI3ySnLw9Ok1EFddg4jGmWiQvQZ6lpr/M/8zlTYk=@vger.kernel.org
X-Gm-Message-State: AOJu0YyUSVBc3swct+/AL8RfFLDtWO+qSrcPJvT8acU5fpEveuO73+LE
	181MW3RvKFk+v2XN4BolX2/KNwLuIrdc35i2ZzeyjCsPNx1hJt3ukd7geNyRJlPb5lPuk5gAuxs
	MR6QgZ0c7wOzd4fIjqaoenSUAiGUKF29kegEZjeQb9wdUTBlTkl+Jkg==
X-Gm-Gg: Acq92OH1axTqkhieJntk2D6PRweIDQDEv3g3daPIgNwncAUMUjMrgIzk5QIzvbqM27q
	1CDLRPeO6S4M1h6ROnMXp2BeqhOFkKx6zsM6eN3sgi9ZRnCo/bZ6jtP/NSb6lgwtCVZfu5Y7SoJ
	TRCDzW3HkBsZlws/YpAb2zMkl68OrBEruvbkHoVqIF2+lmPQQ9ugdOMIxFoElDhnboVurW8p6MY
	DeOcQcoARNwXRFlgjvSJeK2ws35uogAT+63AJ4L3l87lrP7pr2wLELtUGBTQxR45KQeeugzfYji
	QcXgjyy+washplzjxbo5FdX2R8OodWvpuWXl426+TsGmmORLch7otAOuwOv/kD0OWH2pRYIJEY0
	f3DoFhsfGXBGcHk3taeItr8HPOflZi4EBKj2GcHj+Uu60kk6xtMpj3dfUy0nFOZSh5zmG8JBqyP
	PwdqqSmU1ioepOfhkA0zzjSj2d/g==
X-Received: by 2002:a17:907:a789:b0:bd2:bd3:1ef8 with SMTP id a640c23a62f3a-bdd272cfb68mr441494666b.35.1779523540761;
        Sat, 23 May 2026 01:05:40 -0700 (PDT)
X-Received: by 2002:a17:907:a789:b0:bd2:bd3:1ef8 with SMTP id a640c23a62f3a-bdd272cfb68mr441493266b.35.1779523540381;
        Sat, 23 May 2026 01:05:40 -0700 (PDT)
Received: from [172.101.1.88] ([185.48.102.178])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-688bb13312fsm1606544a12.22.2026.05.23.01.05.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 23 May 2026 01:05:39 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: Hisam Mehboob <hisamshar@gmail.com>
Cc: Sean Christopherson <seanjc@google.com>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Brigham Campbell <me@brighamcampbell.com>,
	kvm@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] KVM: selftests: elf: Include <endian.h> instead of <bits/endian.h>
Date: Sat, 23 May 2026 10:05:35 +0200
Message-ID: <20260523080535.154440-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260409164020.1575176-4-hisamshar@gmail.com>
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

