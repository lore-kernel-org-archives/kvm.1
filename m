Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 091F447A86A
	for <kvm@vger.kernel.org>; Fri,  7 Aug 2026 13:20:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786108833; cv=none; b=HlWWAjc5nu//z2uo7mkhjHJup+4vU66vFeFPNLfnwrxCB3lLRw8hi3nZrU4sY/GKkT4q71V8OVNEXl4NQzgXBUAxg1ZtJofm0H3+jlYzM1ftJxI6AKOFVyosTyOIKZJmm9bZaX8ZGHrc3o5x3nJuMXPFBjnOLp78WF7YvDTnU8c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786108833; c=relaxed/simple;
	bh=cyh9GNwkSeiWX8VVWJet6cmrStrv1Y1BhHYKMAKCy08=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XjqXsmkMaZQy+BFPQga/bXmZSiEw6D3Rpv8RzPglRp6pnQcrec4nC7w6UXDbbhiYftud6xFrK7AjuY6H8bx5T4yJdhA9+rgEjOn6ubmvy/CcNN2hc1g2/5xDyrQE0uiizaAPpSWYyA1zAN4kcoHRmJQh1HCItbSYprjnX0ix8x8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=KFl65Zs2; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=qRHG41xG; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KFl65Zs2";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="qRHG41xG"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1786108828;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cyh9GNwkSeiWX8VVWJet6cmrStrv1Y1BhHYKMAKCy08=;
	b=KFl65Zs2C+Z86FX3hF4p+Hzao4wses4hMX51aTE55HUfzjR3RLVpTHEQemMEt7uaNyHWXk
	GVKH9x5Fbr8r4N/XY1xPiv+Gps/MvJAwyo4+8ylPjjqYM+HF91BBrKGujMQ0oS6mVxJC9q
	RBk8z/+8AtFYmJ+AyhJj0zgOE6R6WrA=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-192-aOpPWTjAM_uh9s_h-ymszA-1; Fri, 07 Aug 2026 09:20:22 -0400
X-MC-Unique: aOpPWTjAM_uh9s_h-ymszA-1
X-Mimecast-MFC-AGG-ID: aOpPWTjAM_uh9s_h-ymszA_1786108822
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-47fd4ee0ac0so2568873f8f.2
        for <kvm@vger.kernel.org>; Fri, 07 Aug 2026 06:20:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1786108821; x=1786713621; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=cyh9GNwkSeiWX8VVWJet6cmrStrv1Y1BhHYKMAKCy08=;
        b=qRHG41xGknAovsBiA1dU/1MHO8Nn7SsCkFHf4CF5cZ7f4wRpq1QrTCA8uwT69qAMB5
         nzzWeewyayT8qw5QlNWWurNeI6QCt8O7v+VbXfzImWinHnHk4LGih7ZCXNdGwVTcDfWO
         ANL/SbppzmfMfTmBb3YFMXt9CCcvqZknhzwZUwnZomRq5IidzepWIwwj2AodjT0o7xFR
         LLADZehPfe6hlSKld0JXDdSSzVGcGv2bJgjIxLY1vh5t9kPONb3/4KhvC8Mk47xR6Ug3
         fEWledIjzMn7QQxck9aJmXelNQ68Jkpk98KWscchYmZgNBNlkM3XXiqdn3++onlE0EgM
         wexA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786108821; x=1786713621;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=cyh9GNwkSeiWX8VVWJet6cmrStrv1Y1BhHYKMAKCy08=;
        b=CE+Z6QuRWYf8/dUskjTbqAE0nGVExOiNOs6+0rjxgoGGJI4p2c2JYrxiSi8EJb2ao/
         QNOJCJVARhasm4rdFEHxRQksi02iUZTbqgKU36+gvZD7WkSTGRTaHQYlUH1BmQNIsl0L
         Z4Mt5UQdr+s0mDrcX7bS0oORpQeOYYutGfzt5L31zD5+7ShTLukwOaSJHP2efMItyjub
         cVRVKHZgh21fXR0qugQ5bVvZ6+ATgl2Uho0jb5i1sxeFo3T8W1+0MIwcYzcxTkBoG4pO
         nXRpLyG7cybrtUe2Xcw435Rj1YsAl5Dj+it0wwQSjHuh6/8q5sGk79i+1BtDgC6ZhR9U
         hC1Q==
X-Forwarded-Encrypted: i=1; AHgh+RoaZCqRzvM9f2NMPQk5P06fw40EUHztw42cX0Z22OOU3NSL3jGItXLePdQOk2sHo/mR9oA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyXLak2I1Zzwsp+HS2Pv+BNGZzN1a9RYmpuAZrD28Q/5xGG9TJf
	kWCYSvr9FvP3mpbSVLzlrnWiWDcvnLBBpDtdLQoiLcvHER1aATt48zXtdoZ7h3z8Yjd085YNoy2
	bYbz1xDZbgcZji95UsRP+XdxRPI1CZEsRMP5/S/EQC4GAftwWZKNhyxN/xZgsEA==
X-Gm-Gg: AR+sD10f4LbWH7159sRWNKKrmRFRpb8YgyyDP6oy13XS72HMNFBGfYblSD79RibmjsI
	hUBpGeULZ9CnNvP13blkKZDxYXrl1zHqTDuUYdJfT6De13kFVNJp386JZXk+E/toakL65KXPwp7
	SCc8atLKJMCqIjPTastuJtBXMHTb+COi6YWKAfrWpowEyPIoOkEqFnXivW79aDpU+qgmo0cVAx1
	jzPWFFhz6gyLZabXPS6GLskz3PJm+0OviSl0hOKqvAuBWF5LCulwCGu2Is/0b1wWrmf79QpAojk
	l0J2vuU8NQJQ9vzcx1CG0poqOrPqv7qlcPjU1iMjML+ayxdt2RlneQDuz3Nuf/iRQ8yHMnUiWfE
	SLGdPLJe5zpqPgYIzK8Wh9CIJw2QLKLHPXZq34pJkyVTp29BvXafVsLYbLL4WIW5z53JD7Q9zLO
	00p/E=
X-Received: by 2002:a05:600c:4f82:b0:495:4cb8:42b9 with SMTP id 5b1f17b1804b1-4994e7112a3mr266715485e9.4.1786108821462;
        Fri, 07 Aug 2026 06:20:21 -0700 (PDT)
X-Received: by 2002:a05:600c:4f82:b0:495:4cb8:42b9 with SMTP id 5b1f17b1804b1-4994e7112a3mr266714875e9.4.1786108821122;
        Fri, 07 Aug 2026 06:20:21 -0700 (PDT)
Received: from [192.168.10.48] ([151.95.34.92])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4995427a244sm144184275e9.10.2026.08.07.06.20.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Aug 2026 06:20:20 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: Saul Freedman <fre3dm4n@gmail.com>
Cc: qemu-devel@nongnu.org,
	pbonzini@redhat.com,
	mtosatti@redhat.com,
	kvm@vger.kernel.org,
	qemu-stable@nongnu.org
Subject: Re: [PATCH] target/i386/kvm: Fix CET SSP MSR read feature check
Date: Fri,  7 Aug 2026 15:20:17 +0200
Message-ID: <20260807132017.2609409-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260615033338.1563854-1-fre3dm4n@gmail.com>
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

