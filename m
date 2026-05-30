Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF7C8355F42
	for <kvm@vger.kernel.org>; Sat, 30 May 2026 20:51:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780174293; cv=none; b=JqqRXgfg+/CWAc6FrUyhM/WANHa10b42k3ZG0XDKSEnArWsyvYOdnMkbBOq5TZ0UYZyZEVzEqHgCapLRCjD1MngkiYXmxdJcwVR7P/whQylx2FfMDJ4W6k2+B4wOcj8wbphW/fB0uL2bc4Bv99HUMMCOiiBF9SIeFbGiNZ9ckD4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780174293; c=relaxed/simple;
	bh=cyh9GNwkSeiWX8VVWJet6cmrStrv1Y1BhHYKMAKCy08=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uYmxwaGSjAOOxfc7PUG+U8xXq4tmUHrKWGcBqHjnsFB1lTtOvgqPVGm2wkd73CNih48EBP0xbHsDRolqt1BXNxofgpGxKI1+JXHyghpjIDr+TBCVlaMcr6KpAdhC01taKK82qGxTRAuiZidGrwWv1xuoHOMEeHHioWI7chkzM8s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=LPO8hKDC; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=K73lGEz8; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LPO8hKDC";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="K73lGEz8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1780174289;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cyh9GNwkSeiWX8VVWJet6cmrStrv1Y1BhHYKMAKCy08=;
	b=LPO8hKDC3eQieOR3bOqfQmq/KS9ecZIv6aYFowa+IeI/UJiBPuOVwgqze+pnONXK+4tHE0
	xwGGScwWUGw1Ue9quP7YPKDTuiJKeseBUxQeVfUn1X6/0JweG3KPKgS0Rs+93ar5gdoJZv
	j3Ql03L+gVSsnRQfNI48OV2U94vbr6Q=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-626-lpJhxGNyP2ePzuiDu7Be6A-1; Sat, 30 May 2026 16:51:28 -0400
X-MC-Unique: lpJhxGNyP2ePzuiDu7Be6A-1
X-Mimecast-MFC-AGG-ID: lpJhxGNyP2ePzuiDu7Be6A_1780174287
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-490a767c7dcso852615e9.2
        for <kvm@vger.kernel.org>; Sat, 30 May 2026 13:51:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1780174287; x=1780779087; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cyh9GNwkSeiWX8VVWJet6cmrStrv1Y1BhHYKMAKCy08=;
        b=K73lGEz84zEcGeDiOPX+a6njNZGCH89Gdluakhe57DX+ofQOxlfRPgY3h2ruv9gvp4
         1bwDeU2RXId91Go2VV2su7yYQkpPjI8BEH7djWH5D516N/Sy7FaHMwJANpWGnpfLy0jR
         CnwZBplme8iiJnPo9I3jtvf6qDyAuGO2Uo1lwlEEkzqJNDzGgHftOe3FCCyG9JWMlx2n
         Nk+iysrgs1asUB9sI1Zbloa06+XGXWLrqRJuVvZoMDsqolcTh/t4CQBe+w1fqtby3ecw
         mob3r8oFHQ87bhf2m+5Aeamil/eOoQXdRgKjy3XqSCKTrNFsw6F3VQBrhtc4143ea61M
         IQBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780174287; x=1780779087;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=cyh9GNwkSeiWX8VVWJet6cmrStrv1Y1BhHYKMAKCy08=;
        b=WNT5plwXHipGvjJbZuUcdtx1wioomUSzoSOzDmjTnRQNAsKqtyux6cov+6XxxvZ6fm
         rhAA2DMcyZeUFVLJYuum7ubiI5UrsXhkUJthyXRtkAU273fuIy4liwtbc7CWv2aLhygY
         zCsmLnOaxTdSRvqGuXyFvZaEjDKWcc1qB0VWtDfszvXBjtf/7j5b3I2zGOJLrF+e22Iy
         Q6+wY+tPw05WsVT6NShukfKH1SfpSDqrpDqdDjCzmo9WREAh7AmHxsF4arPFJGJp7D6w
         qW16t4t0JpDndDmCkHGDPvB+gV6oyPu4UB1MJonn53cuvWtJEu4Rds3YknR6LEcA6dlt
         J9TQ==
X-Forwarded-Encrypted: i=1; AFNElJ843FX3hiUPD3t0XJxqZH7Snxgo9IDVYhUATiifHuMPoxq8CM9rwbDgBv9GFpaI+2Lg2H4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyg+YIL0X/idX4CT4vJcd/m2spdsde6Up/vIeUdw+TTdvnpf+TE
	IByolfx5esWpUuuILCJNUiQ8tneNZgnpf4VojvECZ0Jr36D7pNe/7e0lWciFjfOoSAoA3GRCWfq
	hAd67EGUxNbQ7kyJSXoJ3dQLP45/zBdYnu15AARE3atXwer2vztsVrw==
X-Gm-Gg: Acq92OEITyIf/+bWh+dn4Mb8YkrJMD75yOxwZghe8BxdTG3+CMbxic/Nhu6X4wERmBu
	jhBlrhnG5EM9gzASIJtsz4bzdvEaIA6s3DWIRA7Jbm4k3nKJfjZsgygWf3YEJkxHduTDLoSBbdY
	8HM41EljYQVerdllZuf/RFNMzM45wVWaIUZoFSrvjUHyxTl1gqV9xslf6jc+3ShV0oURJslsE/f
	U/1oPkPe2dyHRs8dw+C0EBWB2/1nLa5E0DfAQ/knBiGGPIZY5g1EIPb8/BbLfgbTo1+u3O39vjP
	sQ3EDZGp8PAQWB/vmZaX0Jmtuuk5HNOWkxNufvEnHQVRRENponnN9DvZAinchhD2OLdi94IJ8G/
	W/EVYB+8Oe166uMPE4P8E9kcngBg6zLCGqsqLvwHGO0b7Ec3pDmBhTNFvVHFFWJTKR/PcJb6SOH
	uoYleBlg/hraSB4EjDG5lbtN7tTfXkTes67ZUaOw==
X-Received: by 2002:a05:600c:4e92:b0:48d:366:b962 with SMTP id 5b1f17b1804b1-490a2900ef2mr86340445e9.6.1780174286987;
        Sat, 30 May 2026 13:51:26 -0700 (PDT)
X-Received: by 2002:a05:600c:4e92:b0:48d:366:b962 with SMTP id 5b1f17b1804b1-490a2900ef2mr86340205e9.6.1780174286625;
        Sat, 30 May 2026 13:51:26 -0700 (PDT)
Received: from [192.168.10.48] ([151.49.251.208])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4909c12d2c5sm55797965e9.7.2026.05.30.13.51.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 30 May 2026 13:51:26 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org,
	seanjc@google.com,
	chang.seok.bae@intel.com
Subject: Re: [PATCH v2 0/3] KVM: Macrofy GPR swapping in assembly code
Date: Sat, 30 May 2026 22:51:23 +0200
Message-ID: <20260530205123.1403240-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260515172734.745763-1-pbonzini@redhat.com>
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

