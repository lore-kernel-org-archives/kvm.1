Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9383029D265
	for <kvm@vger.kernel.org>; Sat, 18 Jul 2026 04:14:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784348099; cv=none; b=e1BMlbvVDDIr7g/JbectYVf3NarZiNOQZ0xLbjePeI9LDyzsvDQBMv7Orh3gVOz62QjiZcHQxJx/R0OwL8z54/uJpbjHQZPMVMc81MdJHnT4Z4nDnPC+0KE6XlOqAjfF8ivpt2vOUwDokdseg8wfYYaSDMoNAey+2OONv5Ypttk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784348099; c=relaxed/simple;
	bh=Ou3HEIiPKm38QTThdCiEvMGnc5Ln3dOxrXgAJKXHIXE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=deGH+2UhQwzj2IghvwWZ/CMxGpWed+r+Ke/KUjfd7a7wzANlj46UDqCQ21UNCtFQuwa8ME9Yx1L4LChUfEjeRJGFwqGK0FYCHrN0Z8Ehu5dq5xVyZSsYw3iOY/5jhtXlQlly46TVmHm3P8BfWUdyGDyxoyOTeD4qakMSC/Vvr4k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=o//Xbj7+; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="o//Xbj7+"
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2cf41bab353so10727545ad.0
        for <kvm@vger.kernel.org>; Fri, 17 Jul 2026 21:14:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784348098; x=1784952898; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=kJkPJe7dnY0SCMEmzH6DzLj6JYMgIuFy9yjp47g0SPg=;
        b=o//Xbj7+SXaY7AarkFF+d06F3fbqL5KNroCH2YAZHFYduXGTM4eyACiyxvQc0w85OL
         aKUNqSCQZ+ASP3/xg23ljXzVTEzombw3m7jPhbYrF3+ma4P5wUFho6s7Db0gzaPoRwa1
         DhKNKpKTaDVQy24/XBpMHNlO38Pk3icJQD1Gtf+Lur/rVNfeqWtaCB+Lk6qGnEwHZG/F
         EJvDGHvofOL6Vi9XX3XyDYEe2mJC9d07ADHx7EtvjHBH/lhfve4Qq/PwQ9kj53FQ/5jY
         BCcQOXmAH9+ByiJhtw60N3gklISQUkpdg8kkuZOgJmY3EdJADaARgIRr5pWcbaWnr+1e
         tleA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784348098; x=1784952898;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=kJkPJe7dnY0SCMEmzH6DzLj6JYMgIuFy9yjp47g0SPg=;
        b=gy9LaQXfPScyE1LBARub0JPUbDxO+kDuLzPjgjGkEOvzlX8acdb93NhsnJSklME+Au
         fzNUEqlI/dRhLrLphY/Bb9vo+851o7nNczXw0MXGKxDFBNs9gK52LRKwwG5Bs5AaP0If
         iKZWn8EFzlQ9I21MfgH9fl2JKoVfTrxMPE26c6RLkhC5CuXa9vuK1Tw5ceRltV9Btvg5
         4GxuMgWo90jVeEQ76S7RjMQNzV58pkPrACXatqQYOBZwtI1YGAe2aXr8EsXBduBaZ+On
         9f8yJ5QmDbNPgyWdX7Re/JFT4KGhnwXKTqacXwAOjdr2quUShr9/AyCLPfe4iu5ZZMqu
         xE1A==
X-Forwarded-Encrypted: i=1; AHgh+RoA6daSsASoygWsjATQe2dkIkZ/JzoCixnHbTAHKjDT5HmYFzPfb4PNG3OKUBV0JlsSjoE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxm/jWLzkAJ0Kkz02PbwH+jGvFfd75disFx+psU4CVyfF5tpr41
	yuybVcM4RkT5KtwH60403lgp+dmTc34Cx4npqDUNuOh86P4Gf5uQrLFQ
X-Gm-Gg: AfdE7cnraUcX2YJvWRHdWi/MLFIfBT4S9ncEoXCb1cWxV++RIGRhQ1phj6la7cNXObf
	N+5cS0zHInlPvqJx8mj+p/yuKqU+/CY3a3tFtS6xH3d/K9xc9AbMZ9wQ+6CoLAs74LiRMcDhDNn
	SOvpBbU3cEYfxnowiZWTr1D2YDN/lO9vZqkTGxsLA96GWguN2Jtb4QHbPu4jvNqk1qpQaxsvMMc
	k1lrClDORO9QMo0EPLm7/4c5qmw0wGU31oBBuNDWVSfFKz1s92JiPH1tOhPhfjee9wjbNipPRP8
	ADZR0Le3P9dlsd6r93yEvCKxEbtWfgoYupJzbYkMkxtQU499jlGbd1I8i+/V77s8sJbegT7wGmC
	UPwV26I+lXLR1uf0bai6xxn4IjmGUZmzBOSl8Nfvs6XdTVeGpvG2PV5wTevverYj7pEGJzZYXbI
	SlNABt
X-Received: by 2002:a17:903:1c8:b0:2be:3850:297e with SMTP id d9443c01a7336-2cf349bff53mr53301185ad.31.1784348097757;
        Fri, 17 Jul 2026 21:14:57 -0700 (PDT)
Received: from [127.0.1.1] ([188.253.12.32])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2cf346daf66sm21346695ad.50.2026.07.17.21.14.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jul 2026 21:14:57 -0700 (PDT)
From: Jia Jia <physicalmtea@gmail.com>
To: bvel,
	rtik,
	efwo,
	kodw,
	michael.christie@oracle.com
Cc: slf@hdu.edu.cn,
	mst@redhat.com,
	jasowang@redhat.com,
	pbonzini@redhat.com,
	stefanha@redhat.com,
	eperezma@redhat.com,
	virtualization@lists.linux.dev,
	kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] vhost-scsi: Prevent OOM from invalid protection SGL count
Date: Sat, 18 Jul 2026 12:14:19 +0800
Message-Id: <20260718041420.1452333-1-physicalmtea@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <8f5b5350-0be9-4b79-a6c9-069d418dee30@oracle.com>
References: <20260717142205.103515-1-physicalmtea@gmail.com>
 <8f5b5350-0be9-4b79-a6c9-069d418dee30@oracle.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Before sending my patch, I did a duplicate check against the upstream
linux-next tree, upstream history, publicly searchable mailing-list archives,
and Patchwork. I searched using the vhost-scsi and scatterlist function names,
T10-PI, invalid protection SGL counts, and the OOM/resource-exhaustion
symptoms. I did not find Linfeng's earlier patch.

Could you please point me to Linfeng's patch, or confirm what the additional
check covers? In particular, does it also validate:

    prot_bytes <= exp_data_len

before subtracting prot_bytes from exp_data_len and entering the SGL
mapping path? I had identified this as a related PI length-mismatch path, but
did not include it in the patch I sent.

With a one-byte combined payload and
pi_bytesout=2, KGDB stopped at the following call stack:

    #0  sg_alloc_table_chained(
            table=0xffff88810bbc5108,
            nents=0,
            first_chunk=0xffff888110050000,
            nents_first_chunk=2048)
        at lib/sg_pool.c:117

    #1  vhost_scsi_handle_vq+2295
    #2  vhost worker task
    #3  srso_alias_return_thunk

The stop was at the `BUG_ON(!nents)` instruction in
`sg_alloc_table_chained()`, and the kernel log recorded `kernel BUG at
lib/sg_pool.c:117!`.  This confirms that the PI length check is needed before
the iterator adjustment and SGL mapping path.

If Linfeng's patch covers both the invalid protection SGL count and this PI
length check, I will not submit duplicate work. 

Regarding the AI question: AI assistance was used during the source analysis
and test development. I also checked the relevant code path and the
host-side behavior.
