Received: from mail-dy2-f41.google.com (mail-dy2-f41.google.com [74.125.229.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2334306776
	for <kvm@vger.kernel.org>; Sat,  3 Oct 2026 06:45:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.229.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791009945; cv=none; b=Hj3qFB08o8XIDLrMQMnQG7JG6UytUA9H2AtMoGGqWWckiIcpbnzPM/CcNggfOIFlHy0f4hD2CE1Zo3Gif8a+Y/uER8pU15CBMzEOmRHjSxDH5svfk9edHJYnYL1Vc4H9erm+SECbIrFoF7mwS4OK4YJbPiNl4TfhRSf1GUguqUg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791009945; c=relaxed/simple;
	bh=UaD3I2b18bISdUANA1NJwXoHAKKgZBgwLSormdRjXBI=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:References; b=j5lFwjtcYjbz8HP9oVBAwleA+jwOf2mBVq3/iYw6qf5hWCs2RTQmwerJRj/Jc2slV0/o0sX6hazpMjbOWIXJXdMlFPf8AYv9Fvz1t8FvVg8kZzaDSeH1Smbrdz9DD/tbsfXsDBAT3/tRS5ZxqRFV4u/fl0c8t1HoueuM5t4DTNA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XyzRzQ3i; arc=none smtp.client-ip=74.125.229.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XyzRzQ3i"
Received: by mail-dy2-f41.google.com with SMTP id 5a478bee46e88-34c4a0870d2so47584eec.2
        for <kvm@vger.kernel.org>; Fri, 02 Oct 2026 23:45:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791009943; x=1791614743; darn=vger.kernel.org;
        h=references:message-id:date:in-reply-to:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=UaD3I2b18bISdUANA1NJwXoHAKKgZBgwLSormdRjXBI=;
        b=XyzRzQ3iSZQuxAchhxpIxcPfV1csnse4+jNMnsmlAoqBf5pAjiklo34px9+3b4GntK
         UTQK1WzB3OwZ2PeGMcNjc3CDHpEXoHQAp9W0XepwNQq0Lvv+DvrVPcSA2i1Da5ThhCCE
         nSeX8ChIHIx6eswyotoKakwqYO7gZdIqvqldR/zAxoMeadA6xLEFVWiWdbRqNss4a0TB
         UkZbcRxj4avATP0cg6apzkfrjiVhbIF+rTb1XANaMZJyZZVP/U6UfRCq0/3xMmQUn3rs
         8dQFcJ2FyjNp7l8UXbMq3QDyymm0KPlnohU2CQYPfQ4dthZFC2f+ogmg1J7QqtDZP6Za
         P/JA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791009943; x=1791614743;
        h=references:message-id:date:in-reply-to:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=UaD3I2b18bISdUANA1NJwXoHAKKgZBgwLSormdRjXBI=;
        b=UYaGoxGsP/waCfONxnxTfw6DQqFGB1hQvi6f+/t77PbxtjKh5zuj2JT1Nb+J9Z/Ee7
         i9RFq4MNdVSrh2+Is87STvTt5B5gPF+p7kQzGaHj6sLZsS434BgjA/ZETcQLsCxAsCVw
         0p62vEukDmDh21Mpx77D1nJdlaPrdCmSMcrknO0PFSPQ1xb/IkDn96kW+klV4ZGVs7kB
         bhkyxuQe36PXxJ25sWMOU/9fKWNdavDTlckKw/0SDHs+OonY2NHGz/kysWTb0URTcDqp
         HHBBvt+RDYQru9qgdSmT3QIYvhqVdQ3sjlQfNEhbglnmrHxB8rpBw14bfbfCNUHFin3A
         G4dA==
X-Gm-Message-State: AFq9FYKyccO08BsyYiBg5wI3MYUh1oTL7BYJAsyr3PuN12j2F3cpZdgd
	QiDV8jX2MoH1cldggWZ4XzWS8eJyq3/DI7uuffHqzWwDA58N3KQ91w3E
X-Gm-Gg: AYBFou1Ph5A854QxuivyW2g3WxrbQYyqkqmN3kAbAxWgMtJ2qVUwO038iTAwTKiVcUB
	dMSGTsIgCDzeKpWmwY3sGDAACWyiGDROv14aO+HYvQD4ZXnT/+o5EDuedvBvorrOgRD5HlAeNIT
	SdLF2k8Zsozve8Xthf6zc1jAZ61GvnCL6R6K3iR51ImX9KuTJlGLSsVnfiM8J24SFtwlE84Ub4M
	HhXZR3Lb13enm5SE741ijG9SbTiOXzp+zLobqFw3NxT/Kd5vEEGO8YelN+sZXzzKb3sjQAhZV+L
	szwY/cE8zYuqW+LsaWJMLHOA0JLFDGskqEIXGGppCqkBWZ8JmlFy7c5CT6266gAXZ4BhtG5RMpW
	2uUA9cad/o4zoWNb+0W/7Z9NldhPlPJNKfRxjpg4EHgo0cFh2apykqm+W26bI360rQFhUKS8rGJ
	5XzY9HAbrxwlUxBo9xPnAcItb6dJ9ODABouSJnRJ0G9W0nA5vn+4NwlCrLHu2d+RhXoHCwLJmDi
	0cGaPl2g6NIa/FOrsK2pO+c7BG9yx1FgW7cBhVsNRB5IAZ0bNpeqGQKDqCgOq7b
X-Received: by 2002:a05:7300:f801:b0:351:1170:3481 with SMTP id 5a478bee46e88-35111703551mr2454740eec.29.1791009942568;
        Fri, 02 Oct 2026 23:45:42 -0700 (PDT)
Received: from pve-server ([49.205.216.49])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3511b6f3a32sm522073eec.2.2026.10.02.23.45.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Oct 2026 23:45:41 -0700 (PDT)
From: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
To: Sean Christopherson <seanjc@google.com>
Cc: kvm@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>, linuxppc-dev@lists.ozlabs.org, Michael Ellerman <mpe@ellerman.id.au>, Christophe Leroy <chleroy@kernel.org>, Anushree Mathur <anushree.mathur@linux.ibm.com>, Venkat Rao Bagalkote <venkat88@linux.ibm.com>, Harsh Prateek Bora <harshpb@linux.ibm.com>, Madhavan Srinivasan <maddy@linux.ibm.com>, Shrikanth Hegde <sshegde@linux.ibm.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 6/9] KVM: selftests: Limit the number of VM creates in hardware_disable_test
In-Reply-To: <asAt1NhGFs5HNbvl@google.com>
Date: Sat, 03 Oct 2026 11:31:23 +0530
Message-ID: <ik3jjpak.ritesh.list@gmail.com>
References: <cover.1790101179.git.ritesh.list@gmail.com> <db32438dee67a69609e75d8c43cb070f021137b1.1790101179.git.ritesh.list@gmail.com> <asAt1NhGFs5HNbvl@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Sean Christopherson <seanjc@google.com> writes:

> On Tue, Sep 22, 2026, Ritesh Harjani (IBM) wrote:
>> hardware_disable_test forks several VMs (NR_IERATIONS=512). This patch
>> limits that number to 4 when we know that we are running in constraint
>> host environment. The number 4 is just a safe minimum when
>> kvm_arch_vm_create_may_enomem() can be true.
>
> Please actually explain *why* this is necessary, and where the magic '4' comes.
> I assume there's some system-wide resource at play?

Yes, this is the similar issue of limited resources at L0 for nested-v2
case. This test actually forks and each child creates a VM. Here, the
parent queues the SIGKILL for the child, however it does not waitpid
before the next fork. That means the VM can still be eating the guest
management space at L0 for the nested-v2 guests (until the VM is
completely destroyed).

I agree the number 4 is a bit ugly here. It was just a safe limit. I was
able to spawn multiple VMs ofcourse - but for the sake of enabling this
test I went with some safe minimum.

BTW, since you suggested that in the initial enablement of the kvm PPC
selftests, we need not land this hardware_disable_test, so I will skip
this for now.

-ritesh

