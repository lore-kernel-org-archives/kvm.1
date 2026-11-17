Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=217.140.110.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794931836;
	b=U6uiXSiUv291KZKLnuxJ/2lUdjmyA+kaVnsbCPdPndTizTL+MpATP7/zICQg2RqES3hK
	 xhd4NlAzMmamfurDEl3Rr4OK7cvUOu0fhKyNFw8ed5VOCTM+RXtAW7vDPNtll0NYnMo0Y
	 m0NCMq2km7As7T31aPFllNTNPdo1AJUoWW2mmVU9/jZOaUeB9S/f72N/FrzkPoCZcn7E1
	 EYI8POh6fcRJsDFaRvpFbQjuCvTrUJf0hgT2o15Dmkj4byWwY8sNrC/FEnEtC3GKUAGGO
	 i4YDKftVyDmo6aeU7hQwzlADl3JUUkpmSMS2yXR57dnTWe8pwzuFEvI6eyenFKVEg7g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794931836;
	h=DMARC-Filter:Received:Received:DKIM-Signature:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=vOf04FWppuKg3UW7wxaRtrB9wWnmgejlNG4wVjGUETw=;
	b=0AwNsnpbNxT1a+GDTga4VBsxJOrrMsIOnDQm71uv6N94zqa4iAoNM8RSot3wqMSA9k9w
	 8JOhHff1Grh6uOCAfKKNre7mDmTzhvJEf3rxlMEICp+zXqsqXsd3yF7X6wgJK+egew/wf
	 iqSYqExKj+eKaxdEBSxOekL8eHTFigfPkVJ18cFgbLBcf9wPgHL04rLR9b2EnF9805vG7
	 3vlG5ePKjXqkusDxDIhHMBLL1IAim4wAsiFRl5km3j5ekYYuG7L/ba8jgDZDl4Apz8/Go
	 9q96diuJ9gOKrrSOqXKwbwyhzQ2RrzeJpiZqZhD/hqNOkmt53dM6yRqhZzZP5iXHMqQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=arm.com;
	spf=pass smtp.mailfrom=arm.com;
	dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=hsnCXzfn;
	arc=none smtp.remote-ip=217.140.110.172
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D105606A32C
	for <kvm@vger.kernel.org>; Tue, 17 Nov 2026 16:10:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3D105606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=hsnCXzfn
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6CB051A32;
	Tue, 17 Nov 2026 08:10:32 -0800 (PST)
Received: from gentoo-vm (kajpuc01-mac-mini.manchester.arm.com [10.33.9.44])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 7C2A83F632;
	Tue, 17 Nov 2026 08:10:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1794931835; bh=5huj7F9fL9yV7XXBf4zapbz6dIDjXF3RdFYmFlrBBTs=;
	h=From:To:Cc:Subject:Date:From;
	b=hsnCXzfnqlZTO5xZpe0Qf/m9xfFjJ9gEKSS9MlpWbam91VcLSjhOQbKrk4N6x2YSA
	 XRs+NoK8oDFLyPbtijfCAJrBYdk5sILg2tD/252CSIW1O1u6Nj0HQHk7BO+fDlBkhy
	 Xuu+5fs+c7A9QpMj14/5FyKCyAqa3JEdvJB75uQw=
From: Kajetan Puchalski <kajetan.puchalski@arm.com>
To: kvm@vger.kernel.org
Cc: will@kernel.org,
	julien.thierry.kdev@gmail.com,
	kvmarm@lists.linux.dev,
	Kajetan Puchalski <kajetan.puchalski@arm.com>
Subject: [PATCH kvmtool 1/2] net: dhcp: Fix parsing of resolv.conf
Date: Tue, 17 Nov 2026 16:10:18 +0000
Message-ID: <20261117161019.142337-1-kajetan.puchalski@arm.com>
X-Mailer: git-send-email 2.56.1
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Parsing logic for /etc/resolv.conf currently does not take into account
line breaks and can erroneously interpret e.g. comments in the file as
valid nameservers. Fix the parser to scan line by line and explicitly
expect a bounded key-val pair to resolve the issue.

Signed-off-by: Kajetan Puchalski <kajetan.puchalski@arm.com>
---
 net/uip/dhcp.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/net/uip/dhcp.c b/net/uip/dhcp.c
index 9de5588..a949a6b 100644
--- a/net/uip/dhcp.c
+++ b/net/uip/dhcp.c
@@ -42,13 +42,15 @@ int uip_dhcp_get_dns(struct uip_info *info)
 	int n = 0;
 	FILE *fp;
 	u32 ip;
+	char *line = NULL;
+	size_t capacity = 0;
 
 	fp = fopen("/etc/resolv.conf", "r");
 	if (!fp)
 		return ret;
 
-	while (!feof(fp)) {
-		if (fscanf(fp, "%s %s\n", key, val) != 2)
+	while (getline(&line, &capacity, fp) >= 0) {
+		if (sscanf(line, "%255s %255s", key, val) != 2)
 			continue;
 		if (strncmp("domain", key, 6) == 0)
 			info->domain_name = strndup(val, UIP_DHCP_MAX_DOMAIN_NAME_LEN);
@@ -62,6 +64,7 @@ int uip_dhcp_get_dns(struct uip_info *info)
 		}
 	}
 
+	free(line);
 	fclose(fp);
 	return ret;
 }
-- 
2.56.1

