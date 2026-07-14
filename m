Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B532495531
	for <kvm@vger.kernel.org>; Tue, 14 Jul 2026 15:15:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784042117; cv=none; b=RflnHcdNJYqCQ4N6mER098YjODUvBDEfAR/p8DqMuU5nYOR4B5hFlEbOZkIZRXmIbeFRaiLLgot+F/icpf4G5nzCx5X4Rh6CqIlkw+8MHqx94sXdbzUkiYo99sMx6I1DUXACNcEcMGLgL+AHIl4Jzy7yYdNFcP7FD9Fnr0pG/p8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784042117; c=relaxed/simple;
	bh=YVc+pKa6Xq4074+to6tFg828NsW4PA06kR2BHhEiYWA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=GKhKUY5mI5PJ8zme4wxXYpHwRuZrL+CjKFqVkrgA/nCsplt7WRwZ7WXcGxXO/xXcb2kT/ANPuo55UEGU8xFKUTkD7CTht6+U4X40A59Q6vkwINbPJkuGu1/eDJvkmPTSberBjuAP/xYcpKpOthsIbwOQrFUY4c+AGMhJJr5KgsA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--vipinsh.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=K4t2rlcF; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--vipinsh.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="K4t2rlcF"
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-84870e7f498so5237175b3a.3
        for <kvm@vger.kernel.org>; Tue, 14 Jul 2026 08:15:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1784042114; x=1784646914; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=NsilKFLygw8IS3OsjN731JV3UeNVYFWUky8KZoNrr2s=;
        b=K4t2rlcF3KYL3tUet10Vhgi5pW8myoazkA0EXJwCQmfspyzYTzKSmHJzDNfaeGroes
         tCbeqGVNsJ4dd2Nuqx1ApzTwwtw6PBDgkeUJHHCPpOrBA16NrC62Bb5R+lz7CWci9J9d
         Q2i0o5rpsCpIIESANYDmqbPiDeVjtUrFvNBgg53wmeiXgvBh+F3EJ2pYzi/o99rUxsTO
         CbMjHdpR/rpEf7P16STgHd+xuHWlJeLL8vmStl5ViYP0Jcg4bP6sNvqE15/eZFDr/Ip4
         NDs41oKa1UOYLzn/JRWcSyf5z6WrtPHzPiFIxdb+LZc0N0pkXt8R6wdR8h5IKMWOhP0X
         nkNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784042114; x=1784646914;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=NsilKFLygw8IS3OsjN731JV3UeNVYFWUky8KZoNrr2s=;
        b=I+e00vfKp4GS6rB5xjffrj7HujZ0GLZ1VVsnYtGFR7eOvDzxsxf4Elzq11/pfIxXja
         LH3o1VhlnzGHeyCCX9uxqIIZvFv+aJebsj3wtaHzgy2Kk+fA2EzVTdJGsh+Oy6ZOenLF
         RjIFXPzCdKt3VtOW9eWXI7VkRTiW/+hsBVZHlk0ZCtwPKZGnXoPOqKqP250vs+uvdswa
         /tStp0Uc0TX3WDRIKV8RMiBF/raM64Gz08oGqDLh9f7UpgyT3bCq2Uv5KL/98n9KG9ie
         LJyTikCoZcnfSx+FuAHsVsTmgc5POc0Md2I1+uXaadFx230IPcTnDYzQTQBf4Ob6PNFb
         mbxg==
X-Forwarded-Encrypted: i=1; AHgh+Rq+7G/BXaM+Tlq2WaOmSQia6890mY5GuwRNJ8MBiICMPE4wsRFgvSW0SshLHkFTi/AzhWQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyKfQUGO6xBcNRnALtv8GgBe65rV5e5XQ0DvuEJws1g9l/qco8H
	DoinmYEg0CcIsVa+3HHHcaxhzXC0RAM2ikxH0ozjhw0YIiYiTxoOVOl+pTnd+Bz4jGWF2FbxkVn
	kC4AZJtGKOg==
X-Received: from pfff9.prod.google.com ([2002:a05:6a00:bd09:b0:848:487e:d23c])
 (user=vipinsh job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:992:b0:848:65f3:23c1
 with SMTP id d2e1a72fcca58-848897d7661mr12194779b3a.69.1784042113533; Tue, 14
 Jul 2026 08:15:13 -0700 (PDT)
Date: Tue, 14 Jul 2026 08:14:49 -0700
In-Reply-To: <20260714151505.3466855-1-vipinsh@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260714151505.3466855-1-vipinsh@google.com>
X-Mailer: git-send-email 2.55.0.795.g602f6c329a-goog
Message-ID: <20260714151505.3466855-5-vipinsh@google.com>
Subject: [PATCH v5 04/20] liveupdate: Export symbols needed by modules
From: Vipin Sharma <vipinsh@google.com>
To: kexec@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-doc@vger.kernel.org, kvm@vger.kernel.org, linux-mm@kvack.org, 
	linux-kselftest@vger.kernel.org
Cc: ajayachandra@nvidia.com, alex@shazbot.org, amastro@fb.com, 
	ankita@nvidia.com, apopple@nvidia.com, bhelgaas@google.com, chrisl@kernel.org, 
	christian.koenig@amd.com, corbet@lwn.net, dmatlack@google.com, 
	graf@amazon.com, jacob.pan@linux.microsoft.com, jgg@nvidia.com, jgg@ziepe.ca, 
	jrhilke@google.com, julianr@linux.ibm.com, kees@kernel.org, 
	kevin.tian@intel.com, leon@kernel.org, leonro@nvidia.com, lukas@wunner.de, 
	mattev@meta.com, michal.winiarski@intel.com, parav@nvidia.com, 
	pasha.tatashin@soleen.com, praan@google.com, pratyush@kernel.org, 
	rananta@google.com, rientjes@google.com, rodrigo.vivi@intel.com, 
	rppt@kernel.org, saeedm@nvidia.com, schnelle@linux.ibm.com, 
	skhan@linuxfoundation.org, skhawaja@google.com, vipinsh@google.com, 
	vivek.kasireddy@intel.com, witu@nvidia.com, yanjun.zhu@linux.dev, 
	yi.l.liu@intel.com
Content-Type: text/plain; charset="UTF-8"

Export liveupdate_register_file_handler() and
liveupdate_unregister_file_handler(). All of these will be used by
vfio-pci in a subsequent commit, which can be built as a module.

Reviewed-by: Samiullah Khawaja <skhawaja@google.com>
Reviewed-by: Pranjal Shrivastava <praan@google.com>
Signed-off-by: David Matlack <dmatlack@google.com>
Signed-off-by: Vipin Sharma <vipinsh@google.com>
---
 kernel/liveupdate/luo_file.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/kernel/liveupdate/luo_file.c b/kernel/liveupdate/luo_file.c
index c39f96961a85..dd4e26ac34f0 100644
--- a/kernel/liveupdate/luo_file.c
+++ b/kernel/liveupdate/luo_file.c
@@ -909,6 +909,7 @@ int liveupdate_register_file_handler(struct liveupdate_file_handler *fh)
 	up_write(&luo_register_rwlock);
 	return err;
 }
+EXPORT_SYMBOL_GPL(liveupdate_register_file_handler);
 
 /**
  * liveupdate_unregister_file_handler - Unregister a liveupdate file handler
@@ -926,3 +927,4 @@ void liveupdate_unregister_file_handler(struct liveupdate_file_handler *fh)
 	luo_flb_unregister_all(fh);
 	list_del(&ACCESS_PRIVATE(fh, list));
 }
+EXPORT_SYMBOL_GPL(liveupdate_unregister_file_handler);
-- 
2.55.0.795.g602f6c329a-goog

