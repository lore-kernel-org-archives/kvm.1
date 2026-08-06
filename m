Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 352D978F2F;
	Thu,  6 Aug 2026 06:48:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785998941; cv=none; b=hxNvDChT96NfSGsdNF2yKnOmzxylBX7Ikp3h59SOHz13yeAPpF3BYE5GmIVPvfT4mwOzLLN6Ilg4dKBEXaiX8uaz6/YdNUchNMJBnW/UVOS7WmTa7BSq/7iUBAg5RUvgpL7AIlnd/TGcvyb1jAjdpJmFbqQNOZpE9ZKrtCxkCFo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785998941; c=relaxed/simple;
	bh=UlSxC/IGkFSyEWyf+H6ebBeCR5E2aPJizh7NpsgGceU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=fxWuYCQTS7dzislnABdtOkpQ/Jk9quyRJ7Dw5AI9hZFJKpjbTb+0RDObkfoNZSXgMo9OBRfmr0m5C5wxIh5b67jUQDB0WimxT47g5Ho0F3ZS1H8D5+ngk4lu0/gbhDlKvxWPNi6yJjBUTzpwjMB/IRGL02BNkhkipbxyrr1ZA+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=jI5BYCug; arc=none smtp.client-ip=220.197.31.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="jI5BYCug"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=Pa
	6OiqX1zb8L5xDXhjVSQYi7w3Th9fBmhxjtWgy3xM0=; b=jI5BYCugPDGGpsrCUl
	lz7lduzxWVyY6RhVBHFoul2J8scQggPC2cmzs0LvkJlfb09RD5jykZmSCqy9E0x/
	12361wF/hxKDsMzHL/0sQigXC63MG0Ey/YhK2UqYkr3k1cydLK5AS3gjQ8sufqzm
	UAh35083LT3ls6QsahgAqDJqg=
Received: from localhost.localdomain (unknown [])
	by gzsmtp2 (Coremail) with SMTP id PSgvCgAX4vg_LnRq_fcuKA--.37967S2;
	Thu, 06 Aug 2026 14:48:33 +0800 (CST)
From: "rom.wang" <r4o5m6e8o@163.com>
To: virtualization@lists.linux.dev
Cc: eperezma@redhat.com,
	mst@redhat.com,
	jasowang@redhat.com,
	pabeni@redhat.com,
	kvm@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] tools/virtio: add --features-array switch
Date: Thu,  6 Aug 2026 14:48:31 +0800
Message-Id: <20260806064831.45871-1-r4o5m6e8o@163.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260804080125.79403-4-r4o5m6e8o@163.com>
References: <20260804080125.79403-4-r4o5m6e8o@163.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:PSgvCgAX4vg_LnRq_fcuKA--.37967S2
X-Coremail-Antispam: 1Uf129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73
	VFW2AGmfu7bjvjm3AaLaJ3UbIYCTnIWIevJa73UjIFyTuYvj4R_J5FDUUUU
X-CM-SenderInfo: 3uurkzkwhy0qqrwthudrp/xtbCzgJTyGp0LkKkTAAA3N

This is expected, not a bug in the test.

The clear_user() start-address issue in VHOST_GET_FEATURES_ARRAY is the
pre-existing kernel bug that the separately posted fix [1] (Acked-by:
Eugenio) addresses.  Patch 3 here is its regression test, so it
intentionally aborts in verify_get_features_array() against an unfixed
kernel and passes once [1] is applied; the dependency is noted in the
cover letter.

[1] https://lore.kernel.org/all/20260526080336.61296-1-r4o5m6e8o@163.com/

No virus found
		Checked by Hillstone Network AntiVirus

